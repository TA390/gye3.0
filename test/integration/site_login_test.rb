require 'test_helper'

class SiteLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    # profile created in test/fixtures/volunteers.yml
    @user = volunteers(:bill)
  end
  
  test "valid login and logout" do
    get login_path
    post login_path, session: { email: @user.email, 
                                password: 'password' }
    
    # confirm successful login
    assert is_logged_in?
    
    # test that the redirect target is the user's profile page
    assert_redirected_to @user
    # test the the target was actually followed
    follow_redirect!
    
    
    assert_template 'volunteers/show'
    
    # test that the login button/link disappears after a 
    # successful login
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", volunteer_path(@user)
    
    # delete the current session and test that the user is no
    # longer logged in
    delete logout_path
    assert_not is_logged_in?
    
    # test that the user was redirected to the home page
    assert_redirected_to root_url
    
    # simulate a user clicking logout in a different window
    delete logout_path
    
    follow_redirect!
    
    # test that the correct paths (menu buttons) are visible 
    # to the user (i.e reinstate 'login' and remove 'account')
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", volunteer_path(@user), count: 0
  end
  
  test "invalid login" do
    get login_path
    assert_template 'sessions/new'
    
    # post empty login details
    post login_path, session: { email: "", password: "" }
    
    # test that the site remained on the same page and 
    # displayed a flash message
    assert_template 'sessions/new'
    assert_not flash.empty?
    
    # move to another page and test that the flash message
    # disappears
    get root_path
    assert flash.empty?
  end
  
  # test the behaviour of the cookie when a user select remember me
  test "login and remember the user" do
    log_in_as(@user, remember_me: 1)
    assert_not_nil cookies['remember_token']
  end

  # test the behaviour of the cookie when a user doesn't select remember me
  test "login but don't remember the user" do
    log_in_as(@user, remember_me: 0)
    assert_nil cookies['remember_token']
  end
  
  
end
