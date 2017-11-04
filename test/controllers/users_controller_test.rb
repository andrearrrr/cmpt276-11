require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get login_url
    assert_response :success
  end

end
