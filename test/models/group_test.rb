require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    @group = Group.new(name: "Example Group Name")
  end

  test "should be valid" do
    assert @group.valid?
  end

  test "name should be present" do
    @group.name = "    "
    assert_not @group.valid?
  end

  test "name should be resonable length" do
    @group.name = "a" * 101
    assert_not @group.valid?
  end
end
