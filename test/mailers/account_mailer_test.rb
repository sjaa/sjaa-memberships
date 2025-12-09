require "test_helper"

class AccountMailerTest < ActionMailer::TestCase
  setup do
    @opportunity = Opportunity.create!(
      title: 'Website Development',
      description: 'Help maintain the SJAA website',
      email: 'webmaster@sjaa.net'
    )

    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123'
    )

    @contact = Contact.create!(
      email: 'john.doe@example.com',
      person: @person,
      primary: true
    )

    @person.reload # Reload to get the email from the contact

    @skill1 = Skill.create!(name: 'Ruby on Rails', description: 'Web development')
    @skill2 = Skill.create!(name: 'JavaScript', description: 'Frontend development')
    @skill3 = Skill.create!(name: 'CSS', description: 'Styling')
  end

  test "opportunity_contact email includes basic information" do
    message = "I am interested in helping with this opportunity!"

    email = AccountMailer.opportunity_contact(@opportunity, @person, message)

    assert_emails 0 # Not delivered yet, just created
    assert_equal "[SJAA Volunteer] Interest in: #{@opportunity.title}", email.subject
    assert_includes email.to, 'volunteer@sjaa.net'
    assert_includes email.to, @opportunity.email
    assert_includes email.to, @person.email
    assert_includes email.html_part.body.to_s, @opportunity.title
    assert_includes email.html_part.body.to_s, message
    assert_includes email.html_part.body.to_s, @person.first_name
    assert_includes email.html_part.body.to_s, @person.last_name
  end

  test "opportunity_contact email includes person's skills when present" do
    # Add skills to the person
    PeopleSkill.create!(person: @person, skill: @skill1, skill_level: 3)
    PeopleSkill.create!(person: @person, skill: @skill2, skill_level: 2)

    message = "I have relevant experience!"

    email = AccountMailer.opportunity_contact(@opportunity, @person, message)

    # Check that skills are included
    assert_includes email.html_part.body.to_s, "Volunteer's Skills"
    assert_includes email.html_part.body.to_s, @skill1.name
    assert_includes email.html_part.body.to_s, @skill2.name
    assert_includes email.html_part.body.to_s, 'Advanced' # skill level name for level 3

    # Check text part too
    assert_includes email.text_part.body.to_s, "Volunteer's Skills"
    assert_includes email.text_part.body.to_s, @skill1.name
  end

  test "opportunity_contact email does not show skills section when person has no skills" do
    message = "I'd like to learn!"

    email = AccountMailer.opportunity_contact(@opportunity, @person, message)

    # Should not include skills section
    assert_not_includes email.html_part.body.to_s, "Volunteer's Skills"
  end

  test "opportunity_contact email shows skill match status for required skills" do
    # Person has skills at various levels
    PeopleSkill.create!(person: @person, skill: @skill1, skill_level: 3) # Expert
    PeopleSkill.create!(person: @person, skill: @skill2, skill_level: 1) # Beginner
    PeopleSkill.create!(person: @person, skill: @skill3, skill_level: 2) # Intermediate

    # Opportunity requires specific skills
    OpportunitySkill.create!(opportunity: @opportunity, skill: @skill1, skill_level: 2) # Person exceeds
    OpportunitySkill.create!(opportunity: @opportunity, skill: @skill2, skill_level: 2) # Person is below

    message = "I have some of the required skills!"

    email = AccountMailer.opportunity_contact(@opportunity, @person, message)

    body = email.html_part.body.to_s

    # Should show that skill1 meets requirement
    assert_includes body, @skill1.name
    assert_includes body, 'Meets requirement'

    # Should show that skill2 is below requirement
    assert_includes body, @skill2.name
    assert_includes body, 'Below requirement'

    # skill3 is not required, so should not show match status
    assert_includes body, @skill3.name
    # But the line for skill3 should not have "Meets requirement" or "Below requirement"
  end

  test "opportunity_contact returns NullMail when opportunity is nil" do
    email = AccountMailer.opportunity_contact(nil, @person, "Test message")
    assert_instance_of ActionMailer::Base::NullMail, email.message
  end

  test "volunteer_opportunity_matches email includes all categories" do
    # Create opportunities for each category
    full_match = Opportunity.create!(title: 'Rails Developer', active: true)
    OpportunitySkill.create!(opportunity: full_match, skill: @skill1, skill_level: 2)

    partial_match = Opportunity.create!(title: 'Full Stack Developer', active: true)
    OpportunitySkill.create!(opportunity: partial_match, skill: @skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: partial_match, skill: @skill2, skill_level: 3)

    no_skills = Opportunity.create!(title: 'Event Volunteer', active: true)

    # Give person skills
    PeopleSkill.create!(person: @person, skill: @skill1, skill_level: 3)
    PeopleSkill.create!(person: @person, skill: @skill2, skill_level: 1)

    email = AccountMailer.volunteer_opportunity_matches(
      @person,
      [full_match],
      [partial_match],
      [no_skills]
    )

    assert_equal '[SJAA] Volunteer Opportunities Match Your Skills', email.subject
    assert_equal [@person.email], email.to

    body = email.html_part.body.to_s

    # Check for all sections
    assert_includes body, 'Great Matches for Your Skills'
    assert_includes body, full_match.title

    assert_includes body, 'Opportunities Where You Could Contribute'
    assert_includes body, partial_match.title

    assert_includes body, 'Open to All Volunteers'
    assert_includes body, no_skills.title

    assert_includes body, 'opportunities'
  end

  test "volunteer_opportunity_matches email with only full matches" do
    full_match = Opportunity.create!(title: 'Rails Developer', active: true)

    email = AccountMailer.volunteer_opportunity_matches(
      @person,
      [full_match],
      [],
      []
    )

    body = email.html_part.body.to_s

    assert_includes body, 'Great Matches for Your Skills'
    assert_includes body, full_match.title
    assert_not_includes body, 'Opportunities Where You Could Contribute'
    assert_not_includes body, 'Open to All Volunteers'
  end

  test "volunteer_opportunity_matches email with no matches encourages browsing" do
    email = AccountMailer.volunteer_opportunity_matches(
      @person,
      [],
      [],
      []
    )

    body = email.html_part.body.to_s

    assert_includes body, 'currently no active opportunities'
    assert_includes body, 'browse all available opportunities'
    assert_includes body, 'opportunities'
  end

  test "volunteer_opportunity_matches includes opportunity descriptions" do
    opportunity = Opportunity.create!(
      title: 'Test Opportunity',
      description: 'This is a test description with **markdown**',
      active: true
    )

    email = AccountMailer.volunteer_opportunity_matches(
      @person,
      [],
      [],
      [opportunity]
    )

    body = email.html_part.body.to_s

    assert_includes body, opportunity.title
    # Markdown should be rendered
    assert_includes body, '<strong>markdown</strong>'
  end

  test "volunteer_opportunity_matches includes required skills for opportunities" do
    opportunity = Opportunity.create!(title: 'Test Opportunity', active: true)
    OpportunitySkill.create!(opportunity: opportunity, skill: @skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: opportunity, skill: @skill2, skill_level: 3)

    email = AccountMailer.volunteer_opportunity_matches(
      @person,
      [],
      [opportunity],
      []
    )

    body = email.html_part.body.to_s

    assert_includes body, 'Required Skills'
    assert_includes body, @skill1.name
    assert_includes body, @skill2.name
    assert_includes body, 'Intermediate' # Level 2
    assert_includes body, 'Advanced' # Level 3
  end

  test "volunteer_opportunity_matches text part includes all content" do
    opportunity = Opportunity.create!(title: 'Test Opportunity', active: true)

    email = AccountMailer.volunteer_opportunity_matches(
      @person,
      [opportunity],
      [],
      []
    )

    text_body = email.text_part.body.to_s

    assert_includes text_body, 'SJAA Volunteer Opportunities'
    assert_includes text_body, @person.first_name
    assert_includes text_body, opportunity.title
    assert_includes text_body, 'GREAT MATCHES FOR YOUR SKILLS'
  end

  test "volunteer_opportunity_matches returns NullMail when person is nil" do
    email = AccountMailer.volunteer_opportunity_matches(nil, [], [], [])
    assert_instance_of ActionMailer::Base::NullMail, email.message
  end

  test "volunteer_opportunity_matches returns NullMail when person has no email" do
    person_no_email = Person.create!(
      first_name: 'No',
      last_name: 'Email',
      password: 'password123'
    )

    email = AccountMailer.volunteer_opportunity_matches(person_no_email, [], [], [])
    assert_instance_of ActionMailer::Base::NullMail, email.message
  end
end
