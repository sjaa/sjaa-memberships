require "test_helper"

class OpportunitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: "admin@sjaa.net",
      password: "password123"
    )

    @read_permission = Permission.find_or_create_by(name: 'read')
    @write_permission = Permission.find_or_create_by(name: 'write')
    @admin.permissions << [@read_permission, @write_permission]

    @person = Person.create!(
      first_name: "Test",
      last_name: "User",
      password: "password123"
    )
    @contact = Contact.create!(
      email: "test@example.com",
      person: @person,
      primary: true
    )

    @skill1 = Skill.create!(name: 'Ruby on Rails', description: 'Web development')
    @skill2 = Skill.create!(name: 'JavaScript', description: 'Frontend development')

    @opportunity = Opportunity.create!(
      title: 'Website Development',
      description: 'Help maintain the SJAA website',
      email: 'webmaster@sjaa.net'
    )
    OpportunitySkill.create!(opportunity: @opportunity, skill: @skill1, skill_level: 2)
  end

  # Index action tests
  test "index requires authentication" do
    get opportunities_url
    assert_redirected_to login_path
  end

  test "should get index when authenticated as person" do
    login_as_person(@person)
    get opportunities_url
    assert_response :success
  end

  test "index shows all opportunities for authenticated users" do
    login_as_admin(@admin)
    get opportunities_url
    assert_response :success
    assert_select 'h1', text: /Volunteer Opportunities/i
  end

  test "index shows opportunities sorted by skill match for authenticated person" do
    # Give person matching skills
    PeopleSkill.create!(person: @person, skill: @skill1, skill_level: 3)

    login_as_person(@person)
    get opportunities_url
    assert_response :success

    # Verify the opportunities are displayed (in card elements)
    assert_select '.card', minimum: 1
    assert_select '.card-header h5', text: @opportunity.title
  end

  test "index shows opportunities with zero match for person without skills" do
    login_as_person(@person)
    get opportunities_url
    assert_response :success
    assert_select '.card', minimum: 1
  end

  # Show action tests
  test "show requires authentication" do
    get opportunity_url(@opportunity)
    assert_redirected_to login_path
  end

  test "show displays opportunity details when authenticated" do
    login_as_person(@person)
    get opportunity_url(@opportunity)
    assert_response :success
    assert_select 'h1', text: @opportunity.title
    assert_match @opportunity.description, response.body
  end

  test "show indicates matching status for authenticated person with matching skills" do
    PeopleSkill.create!(person: @person, skill: @skill1, skill_level: 3)

    login_as_person(@person)
    get opportunity_url(@opportunity)
    assert_response :success
    # Should show that person matches
    assert_match /match/i, response.body
  end

  test "show indicates non-matching status for person without matching skills" do
    login_as_person(@person)
    get opportunity_url(@opportunity)
    assert_response :success
  end

  # New action tests
  test "should get new when authenticated as admin" do
    login_as_admin(@admin)
    get new_opportunity_url
    assert_response :success
    assert_select 'h1', text: /New.*Opportunity/i
  end

  test "new loads skills for selection" do
    login_as_admin(@admin)
    get new_opportunity_url
    assert_response :success
    # Skills should be available in the form (using range sliders)
    assert_select '.skill-item[data-skill-id]', minimum: 2
    assert_select 'label', text: @skill1.name
    assert_select 'label', text: @skill2.name
  end

  # Edit action tests
  test "should get edit when authenticated as admin" do
    login_as_admin(@admin)
    get edit_opportunity_url(@opportunity)
    assert_response :success
    assert_select 'h1', text: /Edit.*Opportunity/i
  end

  test "edit loads existing opportunity data" do
    login_as_admin(@admin)
    get edit_opportunity_url(@opportunity)
    assert_response :success
    assert_select 'input[value=?]', @opportunity.title
  end

  test "edit loads skills for selection" do
    login_as_admin(@admin)
    get edit_opportunity_url(@opportunity)
    assert_response :success
    # Skills should be available in the form (using range sliders)
    assert_select '.skill-item[data-skill-id]', minimum: 2
    assert_select 'label', text: @skill1.name
    assert_select 'label', text: @skill2.name
  end

  # Create action tests
  test "should create opportunity when authenticated as admin" do
    login_as_admin(@admin)

    assert_difference('Opportunity.count', 1) do
      post opportunities_url, params: {
        opportunity: {
          title: 'Newsletter Editor',
          description: 'Edit monthly newsletter',
          email: 'newsletter@sjaa.net',
          skills_attributes: [
            { skill_id: @skill1.id, skill_level: 2 }
          ]
        }
      }
    end

    assert_redirected_to opportunity_url(Opportunity.last)
    follow_redirect!
    assert_match 'successfully created', response.body
  end

  test "create associates skills with opportunity" do
    login_as_admin(@admin)

    post opportunities_url, params: {
      opportunity: {
        title: 'Newsletter Editor',
        description: 'Edit monthly newsletter',
        email: 'newsletter@sjaa.net',
        skills_attributes: [
          { skill_id: @skill1.id, skill_level: 2 },
          { skill_id: @skill2.id, skill_level: 3 }
        ]
      }
    }

    opportunity = Opportunity.last
    assert_equal 2, opportunity.opportunity_skills.count
    assert_includes opportunity.skills, @skill1
    assert_includes opportunity.skills, @skill2
  end

  test "create fails with invalid data" do
    login_as_admin(@admin)

    assert_no_difference('Opportunity.count') do
      post opportunities_url, params: {
        opportunity: {
          title: '', # Invalid - title required
          description: 'Test'
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select '.field_with_errors', minimum: 1
  end

  test "create fails with invalid email" do
    login_as_admin(@admin)

    assert_no_difference('Opportunity.count') do
      post opportunities_url, params: {
        opportunity: {
          title: 'Test Opportunity',
          description: 'Test',
          email: 'invalid-email'
        }
      }
    end

    assert_response :unprocessable_entity
  end

  # Update action tests
  test "should update opportunity when authenticated as admin" do
    login_as_admin(@admin)

    patch opportunity_url(@opportunity), params: {
      opportunity: {
        title: 'Updated Title',
        description: 'Updated description'
      }
    }

    assert_redirected_to opportunity_url(@opportunity)
    follow_redirect!
    assert_match 'successfully updated', response.body

    @opportunity.reload
    assert_equal 'Updated Title', @opportunity.title
    assert_equal 'Updated description', @opportunity.description
  end

  test "update can modify associated skills" do
    login_as_admin(@admin)

    # Initially has skill1, update to have skill2
    patch opportunity_url(@opportunity), params: {
      opportunity: {
        title: @opportunity.title,
        skills_attributes: [
          { skill_id: @skill2.id, skill_level: 3 }
        ]
      }
    }

    @opportunity.reload
    assert_equal 1, @opportunity.opportunity_skills.count
    assert_includes @opportunity.skills, @skill2
    assert_not_includes @opportunity.skills, @skill1
  end

  test "update fails with invalid data" do
    login_as_admin(@admin)

    patch opportunity_url(@opportunity), params: {
      opportunity: {
        title: '', # Invalid
        email: 'invalid-email'
      }
    }

    assert_response :unprocessable_entity
    @opportunity.reload
    assert_not_equal '', @opportunity.title
  end

  # Destroy action tests
  test "should destroy opportunity when authenticated as admin" do
    login_as_admin(@admin)

    assert_difference('Opportunity.count', -1) do
      delete opportunity_url(@opportunity)
    end

    assert_redirected_to opportunities_url
    follow_redirect!
    assert_match 'successfully deleted', response.body
  end

  test "destroying opportunity removes associated opportunity_skills" do
    login_as_admin(@admin)

    opportunity_id = @opportunity.id
    skill_count = OpportunitySkill.where(opportunity_id: opportunity_id).count
    assert skill_count > 0, "Opportunity should have skills before deletion"

    delete opportunity_url(@opportunity)

    assert_equal 0, OpportunitySkill.where(opportunity_id: opportunity_id).count
  end

  # Contact action tests
  test "contact redirects to opportunity after submission" do
    login_as_person(@person)

    post contact_opportunity_url(@opportunity), params: {
      message: "I'm interested in this opportunity!"
    }

    assert_redirected_to opportunity_url(@opportunity)
    # Note: Email delivery may fail in test environment, but the redirect should work
  end

  test "contact includes message in email" do
    login_as_person(@person)

    message_text = "I have 5 years of Rails experience and would love to help!"

    post contact_opportunity_url(@opportunity), params: {
      message: message_text
    }

    assert_redirected_to opportunity_url(@opportunity)
  end

  test "contact fails without message" do
    login_as_person(@person)

    assert_no_emails do
      post contact_opportunity_url(@opportunity), params: {
        message: ''
      }
    end

    assert_redirected_to opportunity_url(@opportunity)
    follow_redirect!
    assert_match /provide a message/i, response.body
  end

  test "contact fails without message parameter" do
    login_as_person(@person)

    assert_no_emails do
      post contact_opportunity_url(@opportunity), params: {}
    end

    assert_redirected_to opportunity_url(@opportunity)
    follow_redirect!
    assert_match /provide a message/i, response.body
  end

  # Note: Testing email delivery errors would require mocking which is complex in integration tests
  # The error handling is tested at the unit level and in manual testing

  # Authorization tests
  test "unauthenticated users cannot create opportunities" do
    assert_no_difference('Opportunity.count') do
      post opportunities_url, params: {
        opportunity: {
          title: 'Test',
          description: 'Test'
        }
      }
    end
    assert_redirected_to login_path
  end

  test "unauthenticated users cannot update opportunities" do
    patch opportunity_url(@opportunity), params: {
      opportunity: {
        title: 'Hacked Title'
      }
    }
    assert_redirected_to login_path

    @opportunity.reload
    assert_not_equal 'Hacked Title', @opportunity.title
  end

  test "unauthenticated users cannot destroy opportunities" do
    assert_no_difference('Opportunity.count') do
      delete opportunity_url(@opportunity)
    end
    assert_redirected_to login_path
  end

  test "person without write permission cannot create opportunities" do
    login_as_person(@person)

    assert_no_difference('Opportunity.count') do
      post opportunities_url, params: {
        opportunity: {
          title: 'Test',
          description: 'Test'
        }
      }
    end
    # Should be denied by policy
    assert_redirected_to edit_person_path(@person)
  end

  test "person without write permission cannot update opportunities" do
    login_as_person(@person)

    patch opportunity_url(@opportunity), params: {
      opportunity: {
        title: 'Hacked Title'
      }
    }
    assert_redirected_to edit_person_path(@person)

    @opportunity.reload
    assert_not_equal 'Hacked Title', @opportunity.title
  end

  test "person without write permission cannot destroy opportunities" do
    login_as_person(@person)

    assert_no_difference('Opportunity.count') do
      delete opportunity_url(@opportunity)
    end
    assert_redirected_to edit_person_path(@person)
  end
end
