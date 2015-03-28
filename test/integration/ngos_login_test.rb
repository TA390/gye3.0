require 'test_helper'

class NgosLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @ngo = ngos(:oxfam)
  end
  
  test "invalid login" do
    get nlogin_path
    assert_template 'ngo_sessions/new'
    post nlogin_path, ngo_session: { email: "", password: "" }
    assert_template 'ngo_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "valid login and out" do
    get login_path
    post nlogin_path, ngo_session: { email: "oxfam@test.com", 
                                     password: "password" }
    
    assert is_ngo_logged_in?
    
    assert_redirected_to @ngo
    follow_redirect!
    assert_template 'ngos/show'
    assert_select "a[href=?]", nlogin_path, count: 0
    assert_select "a[href=?]", nlogout_path
    assert_select "a[href=?]", ngo_path(@ngo)
    
    delete nlogout_path
    assert_not is_ngo_logged_in?
    assert_redirected_to root_url
    
    # simulate an attempt tp logout in a second window
    delete logout_path
    
    follow_redirect!
    assert_select "a[href=?]", vlogin_path
    assert_select "a[href=?]", vlogout_path,      count: 0
    assert_select "a[href=?]", ngo_path(@ngo), count: 0
  end

    
  
  test "remember login" do
    log_in_as(@ngo, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@ngo, remember_me: '0')
    assert_nil cookies['remember_token']
  end
  
end