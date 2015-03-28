require 'test_helper'

class NgoSessionsHelperTest < ActionView::TestCase

  def setup
    # user deifned in fixtures
    @ngo = ngos(:oxfam)
    # set remember me for user
    remember_ngo(@ngo)
  end

  test "current_ngo - returns correct user when session is nil" do
    # check that the current user is equal to 'user'
    assert_equal @ngo, current_ngo
    assert is_ngo_logged_in?
  end

  test "current_ngo - returns nil when remember digest is wrong" do
    @ngo.update_attribute(:remember_digest,
      Ngo.digest(Ngo.new_token))
    assert_nil current_ngo
  end

  
  
  
end