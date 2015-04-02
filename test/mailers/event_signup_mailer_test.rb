require 'test_helper'

class EventSignupMailerTest < ActionMailer::TestCase

  test "event signup email" do
    user = volunteers(:bill)
    event = events(:homeless)

    mail = EventSignupMailer.event_signup(user, event)
    assert_equal "GYE Event Confirmation (sign up)", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match user.name, mail.body.encoded
    assert_match event.name, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "event unsubscribe email" do
    user = volunteers(:bill)
    event = events(:homeless)

    mail = EventSignupMailer.event_optout(user, event)
    assert_equal "GYE Event Confirmation (unsubscribe)", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match user.name, mail.body.encoded
    assert_match event.name, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
end