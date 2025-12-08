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
    message = "I'm interested in helping with this opportunity!"

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
end
