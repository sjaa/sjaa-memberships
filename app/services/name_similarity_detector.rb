# Service for detecting duplicate or similar person names
class NameSimilarityDetector
  # Find all people with exact matching names (case-insensitive)
  # Returns groups of people with the same normalized name
  def self.find_exact_matches
    # Group people by normalized full name (lowercase, stripped)
    duplicates = Person.all.group_by { |p| normalize_name(p.first_name, p.last_name) }

    # Keep only groups with 2+ people (actual duplicates)
    duplicates.select { |_name, people| people.size > 1 }
  end

  # Find people with similar names to a given person
  # Returns array of [person, similarity_score] pairs, sorted by score descending
  # Options:
  #   threshold: minimum similarity score (0.0-1.0, default 0.85)
  #   limit: maximum number of results (default 10)
  def self.find_similar(person, threshold: 0.85, limit: 10)
    return [] if person.nil? || person.first_name.blank? || person.last_name.blank?

    results = []

    Person.where.not(id: person.id).find_each do |other|
      next if other.first_name.blank? || other.last_name.blank?

      score = similarity_score(person, other)
      results << [other, score] if score >= threshold
    end

    results.sort_by { |_person, score| -score }.take(limit)
  end

  # Calculate similarity score between two people (0.0 to 1.0)
  # Uses weighted combination of first name and last name similarity
  def self.similarity_score(person1, person2)
    return 0.0 if person1.nil? || person2.nil?

    first_score = string_similarity(
      normalize_string(person1.first_name),
      normalize_string(person2.first_name)
    )

    last_score = string_similarity(
      normalize_string(person1.last_name),
      normalize_string(person2.last_name)
    )

    # Weight last name more heavily (60%) than first name (40%)
    (first_score * 0.4) + (last_score * 0.6)
  end

  # Check if a person with similar name exists
  # Returns true if at least one similar person found
  def self.exists_similar?(person, threshold: 0.85)
    find_similar(person, threshold: threshold, limit: 1).any?
  end

  private

  # Normalize a full name for comparison
  def self.normalize_name(first_name, last_name)
    "#{normalize_string(first_name)} #{normalize_string(last_name)}"
  end

  # Normalize a string: downcase, strip whitespace, remove extra spaces
  def self.normalize_string(str)
    return '' if str.nil?
    str.to_s.strip.downcase.gsub(/\s+/, ' ')
  end

  # Calculate Levenshtein distance-based similarity between two strings
  # Returns 0.0 (completely different) to 1.0 (identical)
  def self.string_similarity(str1, str2)
    return 1.0 if str1 == str2
    return 0.0 if str1.empty? || str2.empty?

    distance = levenshtein_distance(str1, str2)
    max_length = [str1.length, str2.length].max

    # Convert distance to similarity score
    1.0 - (distance.to_f / max_length)
  end

  # Calculate Levenshtein distance between two strings
  # Classic dynamic programming algorithm
  def self.levenshtein_distance(str1, str2)
    return str2.length if str1.empty?
    return str1.length if str2.empty?

    # Create matrix
    matrix = Array.new(str1.length + 1) { Array.new(str2.length + 1, 0) }

    # Initialize first row and column
    (0..str1.length).each { |i| matrix[i][0] = i }
    (0..str2.length).each { |j| matrix[0][j] = j }

    # Fill matrix
    (1..str1.length).each do |i|
      (1..str2.length).each do |j|
        cost = str1[i - 1] == str2[j - 1] ? 0 : 1
        matrix[i][j] = [
          matrix[i - 1][j] + 1,      # deletion
          matrix[i][j - 1] + 1,      # insertion
          matrix[i - 1][j - 1] + cost # substitution
        ].min
      end
    end

    matrix[str1.length][str2.length]
  end
end
