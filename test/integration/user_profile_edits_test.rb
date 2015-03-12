require 'test_helper'

class UsersProfileEdits < ActionDispatch::IntegrationTest

  def setup
    @user = volunteers(:bill)
  end
  
  test "invalid profile edit" do
    log_in_as(@user)
    get edit_volunteer_path(@user)
    assert_template 'volunteers/edit'
    patch volunteer_path(@user), 
      volunteer: {first_name: "",
                  last_name: "",
                  email: "bill@test",
                  location: "",
                  password: "pass",
                  password_confirmation: "word"}
    
    assert_template 'volunteers/edit'
  end
  
  test "valid profile edit and forwarding to the intended page" do
    # get the required destination
    get edit_volunteer_path(@user)
    # log the user in
    log_in_as(@user)
    # check that they arrived at their required destination
    assert_redirected_to edit_volunteer_path(@user)
    
    name  = "William"
    email = "bill_gates@hotmail.com"
    patch volunteer_path(@user), 
      volunteer: { first_name: name,
                   last_name: "Gates",
                   email: email,
                   location: "California",
                   password: "password",
                   password_confirmation: "password" }
    
    # test that a flash messages was displayed
    assert_not flash.empty?
    # test that the user was redirected to their profile page
    assert_redirected_to @user
    # reload the user's information
    @user.reload
    # test that the changes made were updated in the db correctly
    assert_equal @user.first_name, name
    assert_equal @user.email, email
  end
  
end
