require 'test_helper'

class NgosSignupsTest < ActionDispatch::IntegrationTest

  test "invalid ngo signup" do
    get signup_path
    assert_no_difference 'Ngo.count' do
    post ngos_path, ngo: { name:  "",
                           email: "ngo@account",
                           password:              "pass",
                           password_confirmation: "word" }
    end
    
    assert_template 'ngos/new'
    
  end
    
  test "valid ngo signup" do
    get signup_path
    assert_difference 'Ngo.count', 1 do
    post_via_redirect ngos_path, ngo: { name:  "Oxfam",
                                        email: "oxfam@test.com",
                                        password: "password",
                                        password_confirmation: "password" }
    end
    
    # test that the correct page is displayed after successful sign up
    assert_template 'ngos/show'
    # test that the user received a flash message
    assert_not flash.FILL_IN
    
    assert is_ngo_logged_in?
    
  end

end
