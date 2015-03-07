require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

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
  end
  
  
    
  # input a valid user, using count before and after to 
  # check that the new user was inserted into the table
  test "valid sign up" do
    
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
    
    # ensure the profile page is loaded after sign up
    assert_template 'volunteers/show'
  end
  
end