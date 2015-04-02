class EventSignupMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/event_signup_mailer/event_signup
  def event_signup
    EventSignupMailer.event_signup(Volunteer.first, Event.first)
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/event_signup_mailer/event_optout
  def event_optout
    EventSignupMailer.event_optout(Volunteer.first, Event.first)
  end

end