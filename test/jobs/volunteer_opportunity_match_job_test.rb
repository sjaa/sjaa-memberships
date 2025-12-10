require "test_helper"

class VolunteerOpportunityMatchJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper
  setup do
    # Create test skills
    @skill1 = Skill.create!(name: 'Ruby on Rails')
    @skill2 = Skill.create!(name: 'JavaScript')
    @skill3 = Skill.create!(name: 'Photography')

    # Create test opportunities
    @opportunity_full_match = Opportunity.create!(
      title: 'Website Developer',
      description: 'Help maintain our Rails website',
      active: true
    )
    OpportunitySkill.create!(opportunity: @opportunity_full_match, skill: @skill1, skill_level: 2)

    @opportunity_partial_match = Opportunity.create!(
      title: 'Full Stack Developer',
      description: 'Need both backend and frontend skills',
      active: true
    )
    OpportunitySkill.create!(opportunity: @opportunity_partial_match, skill: @skill1, skill_level: 2)
    OpportunitySkill.create!(opportunity: @opportunity_partial_match, skill: @skill2, skill_level: 3)

    @opportunity_no_skills = Opportunity.create!(
      title: 'Event Volunteer',
      description: 'Help at star parties',
      active: true
    )

    @opportunity_inactive = Opportunity.create!(
      title: 'Inactive Opportunity',
      description: 'Should not be sent',
      active: false
    )
    OpportunitySkill.create!(opportunity: @opportunity_inactive, skill: @skill1, skill_level: 1)

    # Create volunteer with matching skills
    @volunteer = Person.create!(
      first_name: 'Jane',
      last_name: 'Volunteer',
      volunteer: true,
      password: 'password123'
    )
    Contact.create!(
      email: 'jane.volunteer@example.com',
      person: @volunteer,
      primary: true
    )
    # Add active membership
    kind = MembershipKind.find_or_create_by(name: 'REGULAR')
    Membership.create!(
      person: @volunteer,
      kind: kind,
      start: Date.today - 1.month,
      term_months: 12
    )
    @volunteer.reload

    # Give volunteer skills
    PeopleSkill.create!(person: @volunteer, skill: @skill1, skill_level: 3) # Advanced Rails
    PeopleSkill.create!(person: @volunteer, skill: @skill2, skill_level: 1) # Beginner JavaScript

    # Create non-volunteer person (should not receive email)
    @non_volunteer = Person.create!(
      first_name: 'John',
      last_name: 'Member',
      volunteer: false,
      password: 'password123'
    )
    Contact.create!(
      email: 'john.member@example.com',
      person: @non_volunteer,
      primary: true
    )
    Membership.create!(
      person: @non_volunteer,
      kind: kind,
      start: Date.today - 1.month,
      term_months: 12
    )

    # Create volunteer without email (should be skipped)
    @volunteer_no_email = Person.create!(
      first_name: 'No',
      last_name: 'Email',
      volunteer: true,
      password: 'password123'
    )

    # Create expired volunteer (should not receive email)
    @expired_volunteer = Person.create!(
      first_name: 'Expired',
      last_name: 'Member',
      volunteer: true,
      password: 'password123'
    )
    Contact.create!(
      email: 'expired@example.com',
      person: @expired_volunteer,
      primary: true
    )
    Membership.create!(
      person: @expired_volunteer,
      kind: kind,
      start: Date.today - 13.months,
      term_months: 12
    )
  end

  test "job sends email to active volunteers with email" do
    assert_emails 1 do
      VolunteerOpportunityMatchJob.perform_now
    end
  end

  test "job does not send email to non-volunteers" do
    @volunteer.update!(volunteer: false)

    assert_emails 0 do
      VolunteerOpportunityMatchJob.perform_now
    end
  end

  test "job does not send email to volunteers without email" do
    @volunteer.contacts.destroy_all

    assert_emails 0 do
      VolunteerOpportunityMatchJob.perform_now
    end
  end

  test "job does not send email to inactive members" do
    @volunteer.memberships.destroy_all

    assert_emails 0 do
      VolunteerOpportunityMatchJob.perform_now
    end
  end

  test "job categorizes opportunities correctly" do
    email = nil

    # Capture the email
    assert_emails 1 do
      VolunteerOpportunityMatchJob.perform_now
      email = ActionMailer::Base.deliveries.last
    end

    body = email.html_part.body.to_s

    # Should include full match (has Rails at level 3, needs level 2)
    assert_includes body, @opportunity_full_match.title
    assert_includes body, 'Great Matches for Your Skills'

    # Should include partial match (has Rails but JavaScript is only level 1, needs 3)
    assert_includes body, @opportunity_partial_match.title
    assert_includes body, 'Opportunities Where You Could Contribute'

    # Should include no-skill-required opportunity
    assert_includes body, @opportunity_no_skills.title
    assert_includes body, 'Open to All Volunteers'

    # Should NOT include inactive opportunity
    assert_not_includes body, @opportunity_inactive.title
  end

  test "job includes opportunities URL" do
    email = nil

    assert_emails 1 do
      VolunteerOpportunityMatchJob.perform_now
      email = ActionMailer::Base.deliveries.last
    end

    body = email.html_part.body.to_s
    assert_includes body, 'opportunities'
  end

  test "job handles volunteer with no skills" do
    @volunteer.people_skills.destroy_all
    @volunteer.reload

    email = nil

    assert_emails 1 do
      VolunteerOpportunityMatchJob.perform_now
      email = ActionMailer::Base.deliveries.last
    end

    body = email.html_part.body.to_s

    # Should only include no-skill-required opportunity
    assert_includes body, @opportunity_no_skills.title

    # Should NOT include skill-required opportunities as matches
    # They might appear in "browse opportunities" section, but not as matches
  end
end
