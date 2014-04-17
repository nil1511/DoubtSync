require 'test_helper'

class ResumeControllerTest < ActionController::TestCase
  test "should get daiict" do
    get :daiict
    assert_response :success
  end

end
