require 'test_helper'

class VolunteersControllerTest < ActionController::TestCase
  
  def setup
    @generic_user = volunteers(:bill)
    
    @second_user = volunteers(:steve)
  end
  
  # Volunteer Page
  test "should get volunteer" do
    get :index
    assert_response :success
    assert_select "title", "Volunteer"
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "redirect user trying to edit when not logged in" do
    get :edit, id: @generic_user
    assert_not flash.empty?
    assert_redirected_to login_url

  end
  
  test "redirect user trying to update when not logged in" do
    patch :update, id: @generic_user, 
      volunteer: { name: @generic_user.name, 
                   email: @generic_user.email }
    
    assert_not flash.empty?
    assert_redirected_to login_url

  end
  
  test "redirect user trying to edit a profile that isn't theirs" do
    log_in_as(@second_user)
    get :edit, id: @generic_user
    assert flash.empty?
    assert_redirected_to root_url

  end

  test "redirect user trying to update a profile that isn't theirs" do
    log_in_as(@second_user)
    
    patch :update, id: @generic_user, volunteer: { name: @generic_user.name, 
                                                      email: @generic_user.email }
    assert flash.empty?
    assert_redirected_to root_url
    
  end
  
  test "redirect user trying to access 'my events' page if not signed in" do
    get :event_volunteers, id: @generic_user
    assert_redirected_to login_url
  end

end
