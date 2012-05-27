require 'test_helper'

class LeaderboardControllerTest < ActionController::TestCase
  test "should get points" do
    get :points
    assert_response :success
  end

end
