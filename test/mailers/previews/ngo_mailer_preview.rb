# Preview all emails at http://localhost:3000/rails/mailers/ngo_mailer
class NgoMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/ngo_mailer/account_activation
  def account_activation
    ngo = Ngo.first
    ngo.activation_token = Ngo.new_token
    NgoMailer.account_activation(ngo)
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/ngo_mailer/password_reset
  def password_reset
    ngo = Ngo.first
    ngo.reset_token = Ngo.new_token
    NgoMailer.password_reset(ngo)
  end

end