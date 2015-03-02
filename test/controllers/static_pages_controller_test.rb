require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  # Test GET request on each page
  # should return code 200 'success'
  
  # Home Page
  test "should get home" do
    get :home
    assert_response :success
  end
  
  # About Us Page
  test "should get aboutUs" do
    get :aboutUs
    assert_response :success
  end
  
  # Events Page
  test "should get events" do
    get :events
    assert_response :success
  end
  
  # Volunteer Page
  test "should get volunteer" do
    get :volunteer
    assert_response :success
  end

end
