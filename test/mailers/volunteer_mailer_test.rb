require 'test_helper'

class VolunteerMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = volunteers(:bill)
    user.activation_token = Volunteer.new_token
    mail = VolunteerMailer.account_activation(user)
    assert_equal "GYE - Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match user.first_name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    mail = VolunteerMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end