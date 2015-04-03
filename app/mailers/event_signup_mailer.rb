class EventSignupMailer < ApplicationMailer
  default from: "giveyoureffort19@gmail.com"
  

  def event_signup(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "GYE Event Confirmation (sign up)")
  end


  def event_optout(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "GYE Event Confirmation (unsubscribe)")
  end
  
end
