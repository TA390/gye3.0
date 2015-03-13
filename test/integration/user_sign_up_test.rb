require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    # used for acount activation testing  
    ActionMailer::Base.deliveries.clear
  end
  
  # input an invalid user, using count before and after to
  # check that the new user was not inserted into the table
  test "invalid sign up" do
    
    # test the signup path (url) is working
    get signup_path
    
    # check that no insertion was made into the table
    assert_no_difference 'Volunteer.count' do
      
      # erroneous sign up information
      post volunteers_path, 
      volunteer: {first_name:  "",
                  last_name:  "",
                  email: "joebloggs",
                  gender: "",
                  location: "",
                  password: "pass",
                  password_confirmation: "word"}
    end
    
    # ensure the page is displayed again when an error occurs
    assert_template 'volunteers/new'
    # ensure message is displayed for a failed sign up
    assert_select 'div#<error_explanation>'
    assert_select 'div.<field_with_errors>'
  end
  
  
    
  # input a valid user, using count before and after to 
  # check that the new user was inserted into the table
  test "valid sign up and account activation" do
    
    # test the signup path (url) is working
    get signup_path
    
    # check that the new entry was successful
    assert_difference 'Volunteer.count', 1 do    
      # valid sign up information
      post volunteers_path, 
      volunteer: {first_name:  "Joe",
                  last_name:  "Bloggs",
                  email: "joe_bloggs@test.com",
                  gender: "M",
                  location: "London",
                  password: "password",
                  password_confirmation: "password"}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:volunteer)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    # ensure the profile page is loaded after sign up
    assert_template 'volunteers/show'
    # test that the user is logged in once signed up
    # helper function defined in test/test_helper.rb
    assert is_logged_in?
  end
  
end