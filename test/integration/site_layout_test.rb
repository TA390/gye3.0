require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "site links" do
      get root_path
      assert_template 'static_pages/home'
    # add a count: N when there a multiple route to the same
    # destination (e.g. home btn/logo)
      assert_select "a[href=?]", root_path # count: 2
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", events_path
      assert_select "a[href=?]", volunteers_path
      assert_select "a[href=?]", ngos_path
      
      get signup_path
      assert_select "a[href=?]", signup_path
  end
  
end
