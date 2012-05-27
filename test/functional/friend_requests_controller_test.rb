require 'test_helper'

class FriendRequestsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get approve" do
    get :approve
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
