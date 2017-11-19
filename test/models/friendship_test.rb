require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

#  def setup
  #  @friendship = Friendship.new(send_id: users(:michael).id,
                #                 recieve_id: users(:archer).id)
#  end

  test "should be valid" do
    @friendship = friendships(:one)
    assert @friendship.valid?
  end

#  test "should require a send_id" do

  #  @friendship.send_id = nil
#    assert_not @friendship.valid?
#  end

#  test "should require a recieve_id" do
  #  @friendship.recieve_id = " "
  #  assert_not @friendship.valid?
#  end

end
