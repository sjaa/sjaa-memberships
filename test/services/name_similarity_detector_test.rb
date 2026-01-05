require 'test_helper'

class NameSimilarityDetectorTest < ActiveSupport::TestCase
  setup do
    # Create test people with various names
    @john_smith = Person.create!(first_name: 'John', last_name: 'Smith', password: 'password123')
    @john_smith.contacts.create!(email: 'john.smith@example.com', primary: true)

    @jane_smith = Person.create!(first_name: 'Jane', last_name: 'Smith', password: 'password123')
    @jane_smith.contacts.create!(email: 'jane.smith@example.com', primary: true)

    @jon_smith = Person.create!(first_name: 'Jon', last_name: 'Smith', password: 'password123')
    @jon_smith.contacts.create!(email: 'jon.smith@example.com', primary: true)

    @john_smyth = Person.create!(first_name: 'John', last_name: 'Smyth', password: 'password123')
    @john_smyth.contacts.create!(email: 'john.smyth@example.com', primary: true)

    @bob_jones = Person.create!(first_name: 'Bob', last_name: 'Jones', password: 'password123')
    @bob_jones.contacts.create!(email: 'bob.jones@example.com', primary: true)

    @robert_johnson = Person.create!(first_name: 'Robert', last_name: 'Johnson', password: 'password123')
    @robert_johnson.contacts.create!(email: 'robert.johnson@example.com', primary: true)
  end

  test "find_exact_matches returns groups of people with identical names" do
    # Create another John Smith
    duplicate_john = Person.create!(first_name: 'John', last_name: 'Smith', password: 'password123')
    duplicate_john.contacts.create!(email: 'johnsmith2@example.com', primary: true)

    matches = NameSimilarityDetector.find_exact_matches

    # Should have one group with 2 John Smiths
    assert matches.any?, "Should find at least one group of exact matches"

    john_smith_group = matches['john smith']
    assert_not_nil john_smith_group, "Should find 'john smith' group"
    assert_equal 2, john_smith_group.size, "Should have 2 people named John Smith"
    assert_includes john_smith_group, @john_smith
    assert_includes john_smith_group, duplicate_john
  end

  test "find_exact_matches is case-insensitive" do
    # Create a JOHN SMITH (all caps)
    uppercase_john = Person.create!(first_name: 'JOHN', last_name: 'SMITH', password: 'password123')
    uppercase_john.contacts.create!(email: 'john.smith.upper@example.com', primary: true)

    matches = NameSimilarityDetector.find_exact_matches

    john_smith_group = matches['john smith']
    assert_not_nil john_smith_group
    assert_equal 2, john_smith_group.size
    assert_includes john_smith_group, @john_smith
    assert_includes john_smith_group, uppercase_john
  end

  test "find_exact_matches handles whitespace normalization" do
    # Create a person with extra whitespace
    spaced_john = Person.create!(first_name: '  John  ', last_name: '  Smith  ', password: 'password123')
    spaced_john.contacts.create!(email: 'john.smith.spaced@example.com', primary: true)

    matches = NameSimilarityDetector.find_exact_matches

    john_smith_group = matches['john smith']
    assert_not_nil john_smith_group
    assert_equal 2, john_smith_group.size
    assert_includes john_smith_group, @john_smith
    assert_includes john_smith_group, spaced_john
  end

  test "find_exact_matches excludes single entries" do
    matches = NameSimilarityDetector.find_exact_matches

    # Bob Jones and Robert Johnson should not appear (only one of each)
    assert_nil matches['bob jones']
    assert_nil matches['robert johnson']
  end

  test "find_similar finds people with similar names" do
    similar = NameSimilarityDetector.find_similar(@john_smith, threshold: 0.8)

    # Should find Jon Smith (very similar first name, same last name)
    assert similar.any? { |p, _score| p.id == @jon_smith.id }, "Should find Jon Smith"

    # Should find John Smyth (same first name, very similar last name)
    assert similar.any? { |p, _score| p.id == @john_smyth.id }, "Should find John Smyth"

    # Should NOT find Bob Jones (completely different name)
    assert_not similar.any? { |p, _score| p.id == @bob_jones.id }, "Should NOT find Bob Jones"
  end

  test "find_similar excludes the person being searched" do
    similar = NameSimilarityDetector.find_similar(@john_smith, threshold: 0.0)

    # Should not include the person themselves
    assert_not similar.any? { |p, _score| p.id == @john_smith.id }
  end

  test "find_similar respects threshold parameter" do
    # With high threshold, should find fewer matches
    high_threshold_results = NameSimilarityDetector.find_similar(@john_smith, threshold: 0.95)

    # With low threshold, should find more matches
    low_threshold_results = NameSimilarityDetector.find_similar(@john_smith, threshold: 0.5)

    assert low_threshold_results.size >= high_threshold_results.size,
           "Lower threshold should find at least as many matches as higher threshold"
  end

  test "find_similar respects limit parameter" do
    similar = NameSimilarityDetector.find_similar(@john_smith, threshold: 0.5, limit: 2)

    assert_operator similar.size, :<=, 2, "Should respect limit parameter"
  end

  test "find_similar returns results sorted by score descending" do
    similar = NameSimilarityDetector.find_similar(@john_smith, threshold: 0.5)

    return if similar.size < 2 # Need at least 2 results to test sorting

    scores = similar.map { |_person, score| score }
    assert_equal scores, scores.sort.reverse, "Results should be sorted by score descending"
  end

  test "find_similar handles person with blank names" do
    blank_person = Person.new(first_name: '', last_name: '')

    similar = NameSimilarityDetector.find_similar(blank_person)

    assert_equal [], similar, "Should return empty array for person with blank names"
  end

  test "find_similar skips people with blank names in database" do
    # Create a person with blank name
    Person.create!(first_name: '', last_name: '', password: 'password123')

    similar = NameSimilarityDetector.find_similar(@john_smith, threshold: 0.0)

    # All returned people should have non-blank names
    similar.each do |person, _score|
      assert person.first_name.present?, "Should skip people with blank first names"
      assert person.last_name.present?, "Should skip people with blank last names"
    end
  end

  test "similarity_score returns 1.0 for identical names" do
    person1 = Person.new(first_name: 'John', last_name: 'Smith')
    person2 = Person.new(first_name: 'John', last_name: 'Smith')

    score = NameSimilarityDetector.similarity_score(person1, person2)

    assert_equal 1.0, score, "Identical names should have score of 1.0"
  end

  test "similarity_score is case-insensitive" do
    person1 = Person.new(first_name: 'john', last_name: 'smith')
    person2 = Person.new(first_name: 'JOHN', last_name: 'SMITH')

    score = NameSimilarityDetector.similarity_score(person1, person2)

    assert_equal 1.0, score, "Case differences should not affect score"
  end

  test "similarity_score returns 0.0 for nil person" do
    person = Person.new(first_name: 'John', last_name: 'Smith')

    score = NameSimilarityDetector.similarity_score(person, nil)

    assert_equal 0.0, score, "Nil person should have score of 0.0"
  end

  test "similarity_score weights last name more heavily" do
    # Same first name, different last names
    person1 = Person.new(first_name: 'John', last_name: 'Smith')
    person2 = Person.new(first_name: 'John', last_name: 'Jones')
    score_same_first = NameSimilarityDetector.similarity_score(person1, person2)

    # Different first names, same last name
    person3 = Person.new(first_name: 'John', last_name: 'Smith')
    person4 = Person.new(first_name: 'Jane', last_name: 'Smith')
    score_same_last = NameSimilarityDetector.similarity_score(person3, person4)

    # Same last name should yield higher score due to 60% weighting
    assert score_same_last > score_same_first,
           "Same last name should score higher than same first name (60% vs 40% weight)"
  end

  test "exists_similar? returns true when similar person exists" do
    result = NameSimilarityDetector.exists_similar?(@john_smith, threshold: 0.85)

    # Should find Jon Smith and/or John Smyth
    assert result, "Should find at least one similar person"
  end

  test "exists_similar? returns false when no similar person exists" do
    result = NameSimilarityDetector.exists_similar?(@bob_jones, threshold: 0.95)

    # Bob Jones has no very similar names in the test data
    assert_not result, "Should not find similar people with high threshold"
  end

  test "normalize_string handles nil values" do
    # This is a private method, but we can test it indirectly
    person1 = Person.new(first_name: nil, last_name: 'Smith')
    person2 = Person.new(first_name: '', last_name: 'Smith')

    # Should not raise error
    assert_nothing_raised do
      NameSimilarityDetector.similarity_score(person1, person2)
    end
  end

  test "levenshtein_distance calculates correctly" do
    # Test through string_similarity which uses levenshtein_distance
    # "kitten" vs "sitting" has Levenshtein distance of 3
    # max_length = 7, so similarity = 1 - (3/7) ≈ 0.571

    # Test identical strings
    assert_equal 1.0, NameSimilarityDetector.send(:string_similarity, 'test', 'test')

    # Test completely different strings
    assert_operator NameSimilarityDetector.send(:string_similarity, 'abc', 'xyz'), :<, 0.5

    # Test similar strings
    score = NameSimilarityDetector.send(:string_similarity, 'john', 'jon')
    assert_operator score, :>, 0.6, "Similar strings should have high similarity"
  end

  test "string_similarity handles empty strings" do
    assert_equal 0.0, NameSimilarityDetector.send(:string_similarity, '', 'test')
    assert_equal 0.0, NameSimilarityDetector.send(:string_similarity, 'test', '')
  end
end
