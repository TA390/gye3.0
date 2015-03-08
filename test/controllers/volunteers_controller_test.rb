require 'test_helper'

class VolunteersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
