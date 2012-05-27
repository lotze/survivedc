require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  test "should get runners" do
    get :runners
    assert_response :success
  end

  test "should get checkpoints" do
    get :checkpoints
    assert_response :success
  end

  test "should get chasers" do
    get :chasers
    assert_response :success
  end

end
