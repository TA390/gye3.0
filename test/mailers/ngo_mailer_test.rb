require 'test_helper'

class NgoMailerTest < ActionMailer::TestCase

  test "account_activation" do
    ngo = ngos(:oxfam)
    ngo.activation_token = Ngo.new_token
    mail = NgoMailer.account_activation(ngo)
    assert_equal "GYE Account Activation", mail.subject
    assert_equal [ngo.email], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match ngo.name,               mail.body.encoded
    assert_match ngo.activation_token,   mail.body.encoded
    assert_match CGI::escape(ngo.email), mail.body.encoded
  end

  test "password_reset" do
    ngo = ngos(:oxfam)
    ngo.reset_token = Ngo.new_token
    mail = NgoMailer.password_reset(ngo)
    assert_equal "GYE Password Reset", mail.subject
    assert_equal [ngo.email], mail.to
    assert_equal ["noreply@gye.com"], mail.from
    assert_match ngo.reset_token, mail.body.encoded
    assert_match CGI::escape(ngo.email), mail.body.encoded
  end
end