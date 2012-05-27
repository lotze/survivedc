require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get next" do
    get :next
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
