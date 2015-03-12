require 'test_helper'

class VolunteersControllerTest < ActionController::TestCase
  
  def setup
    @user = volunteers(:bill)
    @second_user = volunteers(:tom)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "redirect user trying to edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "redirect user trying to update when not logged in" do
    patch :update, id: @user, 
      volunteer: { first_name: @user.first_name, 
                   email: @user.email }
    
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "redirect user trying to edit a profile that isn't theirs" do
    log_in_as(@second_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "redirect user trying to update a profile that isn't theirs" do
    log_in_as(@second_user)
    patch :update, id: @user, user: { first_name: @user.first_name, 
                                      email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
