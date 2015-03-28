# Preview all emails at http://localhost:3000/rails/mailers/volunteer_mailer
class VolunteerMailerPreview < ActionMailer::Preview
  
  # Preview this email at
  # http://localhost:3000/rails/mailers/volunteer_mailer/account_activation
  def account_activation
    user = Volunteer.first
    user.activation_token = Volunteer.new_token
    VolunteerMailer.account_activation(user)
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/volunteer_mailer/password_reset
  def password_reset
    user = Volunteer.first
    user.reset_token = Volunteer.new_token
    VolunteerMailer.password_reset(user)
  end

end