require 'test_helper'

class NgoPasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @ngo = ngos(:oxfam)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path, password_reset: { email: @ngo.email }
    assert_not_equal @ngo.reset_digest, @ngo.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    ngo = assigns(:ngo)
    # Wrong email
    get edit_password_reset_path(ngo.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive ngo
    ngo.toggle!(:activated)
    get edit_password_reset_path(ngo.reset_token, email: ngo.email)
    assert_redirected_to root_url
    ngo.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: ngo.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(ngo.reset_token, email: ngo.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", ngo.email
    # Invalid password & confirmation
    patch password_reset_path(ngo.reset_token),
          email: ngo.email,
          ngo: { password:              "password",
                 password_confirmation: "abcdefgh" }
    assert_select 'div#ngo_error_explanation'
    # Blank password
    patch password_reset_path(ngo.reset_token),
          email: ngo.email,
          ngo: { password:              "  ",
                 password_confirmation: "password" }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    # Valid password & confirmation
    patch password_reset_path(ngo.reset_token),
          email: ngo.email,
          ngo: { password:              "password",
                 password_confirmation: "password" }
    assert is_ngo_logged_in?
    assert_not flash.empty?
    assert_redirected_to ngo
  end
  
  test "expired token" do
    get new_password_reset_path
    post password_resets_path, password_reset: { email: @ngo.email }

    @ngo = assigns(:ngo)
    @ngo.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@ngo.reset_token),
          email: @ngo.email,
          ngo: { password:              "password",
                  password_confirmation: "password" }
    assert_response :redirect
    follow_redirect!
    assert_match /FILL_IN/i, response.body
  end
  
end