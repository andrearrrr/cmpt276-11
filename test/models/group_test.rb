require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    @group = Group.new(name: "Example Group Name")
  end

  test "should be valid" do
    assert @group.valid?
  end

  test "should be present" do
    @group.name = "    "
    assert_not @group.valid?
  end
end
