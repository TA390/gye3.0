class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 
  # make the session helpers available everywhere
  include SessionsHelper
  include NgoSessionsHelper 

  private
  
    # test that the ngo is logged in
    def logged_in_ngo
      unless logged_in_ngo?
        store_location
        flash[:danger] = "Please log in."
        redirect_to nlogin_url
      end
    end
end
