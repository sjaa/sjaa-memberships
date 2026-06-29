require "application_system_test_case"

class LifetimeMembershipTest < ApplicationSystemTestCase
  setup do
    @read_permission = Permission.create!(name: 'read')
    @write_permission = Permission.create!(name: 'write')
    @admin = Admin.create!(
      email: 'admin@sjaa.org',
      password: 'password123',
      permissions: [@read_permission, @write_permission]
    )

    @person = Person.create!(
      first_name: 'Jane',
      last_name: 'Smith',
      password: 'password123'
    )

    Contact.create!(
      email: 'jane@example.com',
      person: @person,
      primary: true
    )

    login_as(@admin.email, 'password123')
  end

  test "checking Lifetime checkbox creates membership with nil term_months and no end date" do
    visit edit_person_path(@person)
    expand_memberships_section
    click_on "Add Membership"

    within("#new_membership_0") do
      fill_in "person[membership_attributes][][start]", with: Date.current.strftime('%Y-%m-%d')
      check 'Lifetime'
    end

    click_button_centered "Save Changes"

    assert_text "successfully updated"

    @person.reload
    new_membership = @person.memberships.order(:created_at).last
    assert_not_nil new_membership
    assert_nil new_membership.term_months
    assert_nil new_membership.end
    assert new_membership.is_active?
  end

  test "Lifetime checkbox is pre-checked and term field is cleared when editing an existing lifetime membership" do
    lifetime_membership = Membership.create!(
      person: @person,
      start: 1.year.ago.beginning_of_month,
      term_months: nil
    )

    visit edit_person_path(@person)
    expand_memberships_section

    within("#membership_#{lifetime_membership.id}") do
      assert_field 'Lifetime', checked: true
      assert_equal '', find('[data-membership-target="termMonths"]').value
    end
  end

  test "unchecking Lifetime allows entering term months to convert to timed membership" do
    lifetime_membership = Membership.create!(
      person: @person,
      start: 1.year.ago.beginning_of_month,
      term_months: nil
    )

    visit edit_person_path(@person)
    expand_memberships_section

    within("#membership_#{lifetime_membership.id}") do
      uncheck 'Lifetime'
      fill_in "person[membership_attributes][][term_months]", with: "12"
    end

    click_button_centered "Save Changes"

    assert_text "successfully updated"

    lifetime_membership.reload
    assert_equal 12, lifetime_membership.term_months
    assert_not_nil lifetime_membership.end
  end

  test "Lifetime checkbox is unchecked by default for new memberships" do
    visit edit_person_path(@person)
    expand_memberships_section
    click_on "Add Membership"

    within("#new_membership_0") do
      assert_field 'Lifetime', checked: false
      assert_not_equal '', find('[data-membership-target="termMonths"]').value
    end
  end

  test "admin renew modal supports creating a lifetime membership" do
    visit person_path(@person)

    click_button "Admin Renew"
    assert_selector "#adminRenewModal", visible: true, wait: 2

    within("#adminRenewModal") do
      within("#admin_renew_membership") do
        check 'Lifetime'
      end
      click_button "Create Membership"
    end

    assert_current_path(person_path(@person), wait: 5)
    assert_text "Membership was successfully created"

    @person.reload
    new_membership = @person.memberships.order(:created_at).last
    assert_nil new_membership.term_months
    assert_nil new_membership.end
    assert new_membership.is_active?
  end

  private

  def expand_memberships_section
    find('button[data-bs-target="#memberships-collapse"]').click
    assert_selector('#memberships-collapse.show', wait: 2)
  end
end
