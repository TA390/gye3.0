require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    # user deifned in fixtures
    @user = volunteers(:bill)
    # set remember me for user
    remember(@user)
  end

  test "current_user - returns correct user when session is nil" do
    # check that the current user is equal to 'user'
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user - returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest,
      Volunteer.digest(Volunteer.new_token))
    assert_nil current_user
  end
end