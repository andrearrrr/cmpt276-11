require 'test_helper'

class PicksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get picks_path
    assert_response :success
  end

  test "should get new" do
    get new_pick_path
    assert_response :success
  end


  test "should get show" do
    pick = picks(:one)
    get pick_path(pick)
    assert_response :success
  end

  test "should create pick and redirect to show" do
    assert_difference('Pick.count') do
      post picks_path, params: {pick: { user_id: users(:scott).id,
        player_id: players(:one).id, league_id: leagues(:one).id, award_id: awards(:one).id, season: 2018 } }
    end
    assert_redirected_to pick_path(Pick.last)
    assert_equal 'Pick submitted!', flash[:success]
  end

  test "should delete pick and redirect to index" do
    assert_difference('Pick.count', -1) do
      delete pick_path(picks(:one))
    end
    assert_redirected_to picks_path
    assert_equal 'Pick successfully deleted.', flash[:notice]
  end

  test "should update pick and redirect to index" do
    patch pick_path(picks(:three)), params: { pick: {award_id: awards(:one).id}}
    assert_redirected_to pick_path(picks(:three))
  end

end
