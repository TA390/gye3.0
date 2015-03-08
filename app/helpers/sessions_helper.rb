module SessionsHelper

  # Function to log in the current user (automatically encrypted)
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Function to log out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Function to return the the current user
  def current_user
    @current_user ||= Volunteer.find_by(id: session[:user_id])
  end
  
  # function to test if user is logged in
  # return true if they are or false otherwise
  def logged_in?
    !current_user.nil?
  end
  
end
