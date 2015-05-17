class NgoAccountActivationsController < ApplicationController
  
    def edit
    ngo = Ngo.find_by(email: params[:email])
    if ngo && !ngo.activated? &&
       ngo.authenticated?(:activation, params[:id])
         
         ngo.activate
         log_in_ngo ngo
      flash[:success] = "Account activated - Welcome to Give Your Effort"
         redirect_to ngo
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
  
end
