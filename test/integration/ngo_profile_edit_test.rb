require 'test_helper'

class NgoProfileEditTest < ActionDispatch::IntegrationTest

  def setup
    @ngo = ngos(:oxfam)
  end
  
  test "invalid profile update" do
    log_in_as_ngo(@ngo)
    get edit_ngo_path(@ngo)
    assert_template 'ngos/edit'
    patch volunteer_path(@ngo), ngo: {  name: "",
                                        email: "oxfam@test",
                                        location: "",
                                        url: "",
                                        phone_number: "",
                                        password: "pass",
                                        password_confirmation: "word"}
    
    assert_template 'ngos'
  end
  
  test "valid profile update" do
    
    
    get edit_ngo_path(@ngo)
    log_in_as_ngo(@ngo)
    # redirect to the page they selected before logging in
    assert_redirected_to edit_ngo_path(@ngo)
    name  = "The Ox"
    email = "theox@test.com"
    location = "Brazil"
    patch ngo_path(@ngo), user: { name:  name,
                                   email: email,
                                   location: location,
                                   url: "",
                                   phone_number: "",
                                   password: "",
                                   password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @ngo
    @ngo.reload
    # test that the fields have been updated correctly
    assert_equal @ngo.name, name
    assert_equal @ngo.email, email
    assert_equal @ngo.location, location
  end

  
end
