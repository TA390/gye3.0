module NgoSessionsHelper
  
    # Function to log in the current ngo (automatically encrypted)
  def log_in_ngo(ngo)
    session[:ngo_id] = ngo.id
  end

  # Function to return the the current user specified by the token
  def current_ngo
    if (ngo_id = session[:ngo_id])
      @current_ngo ||= Ngo.find_by(id: ngo_id)
    elsif (ngo_id = cookies.signed[:ngo_id])
      ngo = Ngo.find_by(id: ngo_id)
      if ngo && ngo.authenticated?(cookies[:remember_token])
        log_in_ngo ngo
        @current_ngo = ngo
      end
    end
  end

  def logged_in_ngo?
    !current_ngo.nil?
  end
  
  def log_out_ngo
    forget_ngo(current_ngo)
    session.delete(:ngo_id)
    @current_ngo = nil
  end
  
  def remember_ngo(ngo)
    ngo.remember
    cookies.permanent.signed[:ngo_id] = ngo.id
    cookies.permanent[:remember_token] = ngo.remember_token
  end
  
  def forget_ngo(ngo)
    ngo.forget
    cookies.delete(:ngo_id)
    cookies.delete(:remember_token)
  end
  
  def current_ngo?(ngo)
    ngo == current_ngo
  end
  
  # redirect to stored location (or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # store the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
end
