require 'test_helper'

class AmbassadorControllerTest < ActionController::TestCase
  test "should get proflist" do
    get :proflist
    assert_response :success
  end

  test "should get resumeformat" do
    get :resumeformat
    assert_response :success
  end

end
