ENV['RAILS_ENV'] ||= 'test'

#added 9/3/2015 for rspec testing - DS
require 'simplecov'
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # Function to test if a user is logged in and return true
  # otherwise return false
  def is_logged_in?
    !session[:user_id].nil?
  end
  
    def is_ngo_logged_in?
    !session[:ngo_id].nil?
  end
  
  # Function to log in a test user
  def log_in_as(user, options = {})
    
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    
    if integration_test?
      post vlogin_path, session: { email:       user.email,
                                   password:    password,
                                   remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end

  
  def log_in_as_ngo(ngo, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post nlogin_path, ngo_session: { email:       ngo.email,
                                       password:    password,
                                       remember_me: remember_me }
    else
      session[:ngo_id] = ngo.id
    end
  end
  
  
  
  private

  # Function return true if inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
  
end
