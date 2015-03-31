class NgoMailer < ApplicationMailer

  default from: "giveyoureffort19@gmail.com"
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ngo_mailer.account_activation.subject
  #
  def account_activation(ngo)
    @ngo = ngo
    mail(to: @ngo.email, subject: "GYE Account Activation")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ngo_mailer.password_reset.subject
  #
  def password_reset(ngo)
    @ngo = ngo
    mail(to: @ngo.email, subject: "GYE Password Reset")
  end
end
