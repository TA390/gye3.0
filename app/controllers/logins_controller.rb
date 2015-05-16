class LoginsController < ApplicationController
  
  def new
    # if already logged in redirect to profile
    if session[:ngo_id]
      redirect_to Ngo.find_by(id: session[:ngo_id])
    end
  end

  
  def not_logged_in_ngo?
    
  end
  
end
