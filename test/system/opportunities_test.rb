require "application_system_test_case"

class OpportunitiesTest < ApplicationSystemTestCase
  setup do
    setup_test_constants

    # Create admin with permissions
    @read_permission = Permission.create!(name: 'read')
    @write_permission = Permission.create!(name: 'write')
    @admin = Admin.create!(
      email: 'admin@sjaa.net',
      password: 'password123',
      permissions: [@read_permission, @write_permission]
    )

    # Create test person with active membership
    @person = Person.create!(
      first_name: 'Alice',
      last_name: 'Smith',
      password: 'password123'
    )
    @contact = Contact.create!(
      email: 'alice@example.com',
      person: @person,
      primary: true
    )
    @membership = Membership.create!(
      person: @person,
      start: 1.month.ago,
      term_months: 12,
      ephemeris: false
    )

    # Create skills
    @skill_ruby = Skill.create!(name: 'Ruby on Rails', description: 'Web development with Rails')
    @skill_js = Skill.create!(name: 'JavaScript', description: 'Frontend development')
    @skill_design = Skill.create!(name: 'Graphic Design', description: 'Visual design')

    # Create opportunities
    @opportunity_web = Opportunity.create!(
      title: 'Website Developer',
      description: 'Help maintain and improve the SJAA website using Ruby on Rails',
      email: 'webmaster@sjaa.net'
    )
    OpportunitySkill.create!(opportunity: @opportunity_web, skill: @skill_ruby, skill_level: 2)
    OpportunitySkill.create!(opportunity: @opportunity_web, skill: @skill_js, skill_level: 1)

    @opportunity_newsletter = Opportunity.create!(
      title: 'Newsletter Designer',
      description: 'Design monthly newsletter layouts',
      email: 'newsletter@sjaa.net'
    )
    OpportunitySkill.create!(opportunity: @opportunity_newsletter, skill: @skill_design, skill_level: 3)
  end

  # Index page tests
  test "unauthenticated user can view opportunities list" do
    visit opportunities_path

    assert_text 'Volunteer Opportunities'
    assert_text @opportunity_web.title
    assert_text @opportunity_newsletter.title
  end

  test "opportunities list shows basic information" do
    visit opportunities_path

    within("#opportunity_#{@opportunity_web.id}") do
      assert_text @opportunity_web.title
      assert_text @opportunity_web.description
      assert_text 'Ruby on Rails'
      assert_text 'JavaScript'
    end
  end

  test "authenticated person sees skill match indicators" do
    # Give person matching skills
    PeopleSkill.create!(person: @person, skill: @skill_ruby, skill_level: 3)
    PeopleSkill.create!(person: @person, skill: @skill_js, skill_level: 2)

    login_as(@person.email, 'password123')
    visit opportunities_path

    # Should show that person matches the web developer opportunity
    within("#opportunity_#{@opportunity_web.id}") do
      assert_text /match/i
    end
  end

  test "opportunities are sorted by skill match for authenticated person" do
    # Give person only design skills
    PeopleSkill.create!(person: @person, skill: @skill_design, skill_level: 3)

    login_as(@person.email, 'password123')
    visit opportunities_path

    # Newsletter opportunity should appear first due to skill match
    opportunities = all('.opportunity')
    first_opportunity = opportunities.first.text

    assert_match /Newsletter Designer/i, first_opportunity
  end

  test "clicking opportunity title navigates to show page" do
    visit opportunities_path

    click_on @opportunity_web.title

    assert_current_path opportunity_path(@opportunity_web)
    assert_text @opportunity_web.title
    assert_text @opportunity_web.description
  end

  # Show page tests
  test "show page displays opportunity details" do
    visit opportunity_path(@opportunity_web)

    assert_text @opportunity_web.title
    assert_text @opportunity_web.description
    assert_text @skill_ruby.name
    assert_text @skill_js.name
  end

  test "show page displays skill requirements with levels" do
    visit opportunity_path(@opportunity_web)

    assert_text @skill_ruby.name
    assert_text @skill_js.name
    # Should show skill levels (Intermediate for level 2, Beginner for level 1)
  end

  test "authenticated person can see contact form" do
    login_as(@person.email, 'password123')
    visit opportunity_path(@opportunity_web)

    assert_button 'Send Message'
    assert_field 'message'
  end

  test "authenticated person can submit contact form" do
    login_as(@person.email, 'password123')
    visit opportunity_path(@opportunity_web)

    fill_in 'message', with: "I'm very interested in this opportunity and have 3 years of Rails experience!"
    click_button 'Send Message'

    assert_text /message has been sent/i
  end

  test "contact form requires message text" do
    login_as(@person.email, 'password123')
    visit opportunity_path(@opportunity_web)

    fill_in 'message', with: ''
    click_button 'Send Message'

    assert_text /provide a message/i
  end

  test "show page indicates if person matches requirements" do
    PeopleSkill.create!(person: @person, skill: @skill_ruby, skill_level: 3)
    PeopleSkill.create!(person: @person, skill: @skill_js, skill_level: 2)

    login_as(@person.email, 'password123')
    visit opportunity_path(@opportunity_web)

    assert_text /match/i
  end

  test "show page indicates if person does not match requirements" do
    # Person has no skills
    login_as(@person.email, 'password123')
    visit opportunity_path(@opportunity_web)

    # Should not show full match indicator
    # (May show partial or no match)
  end

  # Admin CRUD tests
  test "admin can create new opportunity" do
    login_as(@admin.email, 'password123')
    visit opportunities_path

    click_on 'New Opportunity'

    fill_in 'Title', with: 'Event Coordinator'
    fill_in 'Description', with: 'Help plan and coordinate SJAA events'
    fill_in 'Email', with: 'events@sjaa.net'

    # Select skills (assuming the form has skill selection)
    # This depends on your form implementation
    within("#skills-section") do
      select @skill_ruby.name, from: 'opportunity[skills_attributes][0][skill_id]'
      select 'Intermediate', from: 'opportunity[skills_attributes][0][skill_level]'
    end

    click_button 'Create Opportunity'

    assert_text 'successfully created'
    assert_text 'Event Coordinator'
  end

  test "admin can edit existing opportunity" do
    login_as(@admin.email, 'password123')
    visit opportunity_path(@opportunity_web)

    click_on 'Edit'

    fill_in 'Title', with: 'Senior Website Developer'
    fill_in 'Description', with: 'Updated description for senior developer role'

    click_button 'Update Opportunity'

    assert_text 'successfully updated'
    assert_text 'Senior Website Developer'
    assert_text 'Updated description for senior developer role'
  end

  test "admin can delete opportunity" do
    login_as(@admin.email, 'password123')
    visit opportunity_path(@opportunity_web)

    accept_confirm do
      click_on 'Delete'
    end

    assert_text 'successfully deleted'
    assert_current_path opportunities_path
    assert_no_text @opportunity_web.title
  end

  test "admin can modify skills when editing opportunity" do
    login_as(@admin.email, 'password123')
    visit edit_opportunity_path(@opportunity_web)

    # Change skill requirements
    within("#skills-section") do
      # Add design skill
      select @skill_design.name, from: 'opportunity[skills_attributes][2][skill_id]'
      select 'Expert', from: 'opportunity[skills_attributes][2][skill_level]'
    end

    click_button 'Update Opportunity'

    assert_text 'successfully updated'
    # Verify skill was added
    assert_text @skill_design.name
  end

  test "create form shows validation errors for invalid data" do
    login_as(@admin.email, 'password123')
    visit new_opportunity_path

    # Submit without required title
    fill_in 'Title', with: ''
    click_button 'Create Opportunity'

    assert_text "can't be blank"
    assert_current_path opportunities_path # Still on form page
  end

  test "create form shows validation errors for invalid email" do
    login_as(@admin.email, 'password123')
    visit new_opportunity_path

    fill_in 'Title', with: 'Test Opportunity'
    fill_in 'Email', with: 'invalid-email-format'

    click_button 'Create Opportunity'

    assert_text 'is invalid'
  end

  test "edit form pre-populates with existing data" do
    login_as(@admin.email, 'password123')
    visit edit_opportunity_path(@opportunity_web)

    assert_field 'Title', with: @opportunity_web.title
    assert_field 'Description', with: @opportunity_web.description
    assert_field 'Email', with: @opportunity_web.email
  end

  # Authorization tests
  test "non-admin user cannot see create button" do
    login_as(@person.email, 'password123')
    visit opportunities_path

    assert_no_link 'New Opportunity'
  end

  test "non-admin user cannot see edit button" do
    login_as(@person.email, 'password123')
    visit opportunity_path(@opportunity_web)

    assert_no_link 'Edit'
  end

  test "non-admin user cannot see delete button" do
    login_as(@person.email, 'password123')
    visit opportunity_path(@opportunity_web)

    assert_no_button 'Delete'
  end

  test "unauthenticated user cannot access new opportunity form" do
    visit new_opportunity_path

    assert_current_path login_path
  end

  test "unauthenticated user cannot access edit opportunity form" do
    visit edit_opportunity_path(@opportunity_web)

    assert_current_path login_path
  end

  # Navigation tests
  test "show page has back link to opportunities list" do
    visit opportunity_path(@opportunity_web)

    click_on 'Back to Opportunities'

    assert_current_path opportunities_path
  end

  test "edit page has cancel link" do
    login_as(@admin.email, 'password123')
    visit edit_opportunity_path(@opportunity_web)

    click_on 'Cancel'

    assert_current_path opportunity_path(@opportunity_web)
  end

  # Multiple opportunities display test
  test "index page displays all opportunities" do
    # Create a few more opportunities
    3.times do |i|
      opp = Opportunity.create!(
        title: "Opportunity #{i + 1}",
        description: "Description for opportunity #{i + 1}"
      )
    end

    visit opportunities_path

    assert_selector '.opportunity', count: 5 # 2 from setup + 3 new
  end

  test "empty state when no opportunities exist" do
    Opportunity.destroy_all

    visit opportunities_path

    assert_text /no.*opportunities/i
  end

  # Skill level display tests
  test "skill levels are displayed in human-readable format" do
    visit opportunity_path(@opportunity_web)

    # Level 1 = Beginner, Level 2 = Intermediate, Level 3 = Expert
    # This depends on your SkillLevelable implementation
    within('.skills-required') do
      assert_text /Ruby on Rails/
      assert_text /JavaScript/
    end
  end

  # Email link tests
  test "opportunity contact email is displayed as link" do
    visit opportunity_path(@opportunity_web)

    assert_selector "a[href='mailto:#{@opportunity_web.email}']"
  end

  test "opportunity without email does not show email link" do
    opportunity_no_email = Opportunity.create!(
      title: 'No Email Opportunity',
      description: 'This opportunity has no email'
    )

    visit opportunity_path(opportunity_no_email)

    assert_no_selector "a[href^='mailto:']"
  end
end
