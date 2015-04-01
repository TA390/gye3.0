require 'test_helper'

class NgosSignupsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
  
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
    
  test "valid ngo signup and acccount activation" do
    get signup_path
    assert_difference 'Ngo.count', 1 do
    post ngos_path, ngo: { name:  "Oxfam",
                           email: "oxfam@test.com",
                           password: "password",
                           password_confirmation: "password" }
    end
    
    assert_equal 1, ActionMailer::Base.deliveries.size
    ngo = assigns(:ngo)
    assert_not ngo.activated?
    # Try to log in before activation.
    log_in_as_ngo(ngo)
    assert_not is_ngo_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_ngo_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(ngo.activation_token, email: 'wrong')
    assert_not is_ngo_logged_in?
    # Valid activation token
    get edit_account_activation_path(ngo.activation_token, 
                                     email: ngo.email)
    assert ngo.reload.activated?
    follow_redirect!
    assert_template 'ngos/show'
    assert is_ngo_logged_in?
    
  end

end
