class NgoSessionsController < ApplicationController
  
  
  def new
    
    v_user = Volunteer.find_by(id: session[:user_id])
    n_user = Ngo.find_by(id: session[:ngo_id])
    
    # if already logged in redirect to profile
    if v_user
      redirect_to v_user
    elsif n_user
      redirect_to n_user
    end
    
  end
  
  def create

    ngo = Ngo.find_by(email: params[:ngo_session][:email].downcase)
    
    if ngo && ngo.authenticate(params[:ngo_session][:password])
      if ngo.activated? == false
        log_in_ngo ngo
        params[:ngo_session][:remember_me] == '1' ? 
          remember_ngo(ngo) : forget_ngo(ngo)
        # redirect to page trying to be accessed or 
        # the home page if an error occurs
        redirect_back_or ngo
      else
        message  = "Account not activated. "
        message += "Please check your email for an activation link."
        flash[:warning] = message
        redirect_to root_url        
      end
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
    
  end

  def destroy

    log_out_ngo if logged_in_ngo?
    redirect_to root_url

  end
  
end
