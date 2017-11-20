require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id,
                                     followed_id: users(:archer).id)
  end

  teardown do
    Rails.cache.clear
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should friend and unfriend a user" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.friends?(archer)

    michael.friend(archer)
    assert archer.followers.include?(michael)

    michael.unfriend(archer)

    assert_not michael.friends?(archer)
  end

  test "should show mutural friends" do
    michael = users(:michael)
    archer = users(:archer)

    assert_not michael.friends?(archer)
    assert_not archer.friends?(michael)
    assert_not michael.mutualfriends?(archer)
    assert_not archer.mutualfriends?(michael)

    michael.friend(archer)
    assert michael.friends?(archer)
    assert_not michael.mutualfriends?(archer)
    assert_not archer.mutualfriends?(michael)

    archer.friend(michael)
    assert archer.friends?(michael)

    assert michael.mutualfriends?(archer)
    assert archer.mutualfriends?(michael)

  end

end
