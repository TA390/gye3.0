class SessionsController < ApplicationController
  
  def new

  end
  
  def create
    
    user = Volunteer.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in(user)
        # remember user if they checked the box
        params[:session][:remember_me] == 1 ? 
          remember(user) : forget(user)
      
        # redirect to their initial destination
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for an activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # display error message.
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    
    log_out if logged_in?
      
    redirect_to root_url

  end
  
end
