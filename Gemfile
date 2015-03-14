source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  
  # 4/3/2015 - added rspec DS
  gem 'rspec-rails', '~> 3.0.0'
  
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
#   # DS added for ER modelling
#   gem "rails-erd"
  
end

# testing environment
# ADDED: 1/3/15
group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end

group :production do
  # Used by Heroku to serve static assets 
  # such as images and stylesheets
  # ADDED: 1/3/15
  gem 'rails_12factor'
  gem 'puma' # production grade server for large amounts of traffic
end

# explicity stated for heroku
ruby '2.2.0'

# Bootstrap gem added 03/03/15
gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'

# email / url validatoion added 04/03/15
gem 'validates_email_format_of'
gem 'validate_url'

# password encryption added 5/3/15
gem 'bcrypt'

# simplecov added 9/3/15
gem 'simplecov', :require => false, :group => :test

# omniauth for fb login 10/3/15
gem 'omniauth-facebook'

# for foreign key generator
gem 'immigrant'

# table inheritance
gem 'active_record-acts_as'
