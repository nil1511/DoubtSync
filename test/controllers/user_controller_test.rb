require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get id" do
    get :id
    assert_response :success
  end

end
