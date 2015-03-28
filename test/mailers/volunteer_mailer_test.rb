require 'test_helper'

class VolunteerMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = volunteers(:bill)
    user.activation_token = Volunteer.new_token
    mail = VolunteerMailer.account_activation(user)
    assert_equal "GYE Account Activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = users(:bill)
    user.reset_token = Volunteer.new_token
    mail = VolunteerMailer.password_reset(user)
    assert_equal "GYE Password Reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
  
end