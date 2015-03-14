require 'test_helper'

class UsersProfileEdits < ActionDispatch::IntegrationTest

  def setup
    @user = volunteers(:tom)
  end
  
  test "invalid profile edit" do
    log_in_as(@user)
    get edit_volunteer_path(@user)
    assert_template 'volunteers/edit'
    patch volunteer_path(@user), 
    volunteer: {name: "",
                  last_name: "",
                  email: "tom@test",
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
    
    name  = "Thomas"
    email = "tom_hanks@hotmail.com"
    patch volunteer_path(@user), 
    volunteer: { name: name,
                   last_name: "Hanks",
                   email: email,
                   location: "California",
                   password: "password",
                   password_confirmation: "password" }
    
    # test that a flash messages was displayed
    assert_not flash.empty?
    # test that the user was redirected to their profile page
    assert_redirected_to @user
    # reload the user's information from the db
    @user.reload
    # test that the changes made were updated in the db correctly
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
  
end
