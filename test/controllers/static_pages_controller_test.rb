require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  # Test All Static Pages
  
  def setup
    # this function is run before a test executes so it can
    # be used to specify variables for duplicated code in the
    # test below ( e.g. @title_variable = "Give Your Effort" )
    # or create an instance variable to test with
  end
  
  # Home Page
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Give Your Effort"
  end
  
  # About Us Page
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About Us"
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
  
    test "should get ngo" do
    get :ngo
    assert_response :success
    assert_select "title", "NGO"
  end

end
