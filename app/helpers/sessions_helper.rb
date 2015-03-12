module SessionsHelper

  # Function to log in the current user (automatically encrypted)
  def log_in(user)
    session[:user_id] = user.id
  end
    
  # Function to forget a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # Function to log out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Function to remember a signed in user
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Function to return true if 'user'is the current user
  def current_user?(user)
    user == current_user
  end
  
  # Function to return the the current user specified by the token
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= Volunteer.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = Volunteer.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # function to test if user is logged in
  # return true if they are or false otherwise
  def logged_in?
    !current_user.nil?
  end
  
  # Function to redirect at user to their intended destination or
  # a 'default' destination
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Function to stores the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
end
