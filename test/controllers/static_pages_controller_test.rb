require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  # Test All Static Pages
  
  def setup
    # this function is run before test executes so it can
    # be used to specify variables for duplicated code in the
    # test below ( e.g. @title_variable = "Give Your Effort" )
  end
  
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
