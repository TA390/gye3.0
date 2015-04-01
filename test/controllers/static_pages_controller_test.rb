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
  

end
