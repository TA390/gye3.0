require 'test_helper'

class NgosControllerTest < ActionController::TestCase
  
  
  def setup
    @ngo = ngos(:oxfam)
    @second_ngo = ngos(:water_aid)
  end
  
  test "should get ngo" do
    get :index
    assert_response :success
    assert_select "title", "Ngo"
  end
  
  test "redirect attempt to call edit when not logged in" do
    get :edit, id: @ngo
    assert_not flash.empty?
    assert_redirected_to nlogin_url
  end

  test "redirect attempt to call update when not logged in" do
    patch :update, id: @ngo, 
      ngo: { name: @ngo.name, email: @ngo.email }
    
    assert_not flash.empty?
    assert_redirected_to nlogin_url
  end
  
  test "redirect attempt to call edit on another ngo's profile" do
    log_in_as_ngo(@second_ngo)
    get :edit, id: @ngo
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "redirect attempt to update another ngo's profile" do
    log_in_as_ngo(@second_ngo)
    patch :update, id: @ngo, 
      ngo: { name: @ngo.name, email: @ngo.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
end
