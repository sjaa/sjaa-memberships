require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "default_membership defaults to false" do
    group = Group.create!(name: "Test Group", email: "test@sjaa.net")
    assert_equal false, group.default_membership
  end

  test "default_membership can be set to true" do
    group = Group.create!(name: "Welcome Group", email: "welcome@sjaa.net", default_membership: true)
    assert group.default_membership
  end

  test "non-joinable group can have default_membership" do
    group = Group.create!(name: "Auto Group", email: "auto@sjaa.net", joinable: false, default_membership: true)
    assert group.default_membership
    assert_not group.joinable
  end
end
