require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  # Test GET request on each page
  # should return code 200 'success'
  
  # Home Page
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Give Your Effort"
  end
  
  # About Us Page
  test "should get aboutUs" do
    get :aboutUs
    assert_response :success
    assert_select "title", "About GYE"
  end
  
  # Events Page
  test "should get events" do
    get :events
    assert_response :success
    assert_select "title", "Events"
  end
  
  # Volunteer Page
  test "should get volunteer" do
    get :volunteer
    assert_response :success
    assert_select "title", "Volunteer"
  end

end
