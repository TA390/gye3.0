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
end
