class SessionsController < ApplicationController
  
  def new

  end
  
  def create
    
    @user = Volunteer.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      
      log_in(@user)
      redirect_to root_path
      
    else
      # display error message.
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    request.env['PATH_INFO']
    
    log_out
      
    redirect_to root_url

  end
  
end
