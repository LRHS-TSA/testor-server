source 'https://rubygems.org'

###
### Core
###

# This is a rails project
gem 'rails', '~> 5.0.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.6.0'
# Use turbolinks to increase page loading speed
gem 'turbolinks', '~> 5.0.1'
# Easy JSON APIs
gem 'jbuilder', '~> 2.6.0'
# Local databases
gem 'sqlite3', '~> 1.3.12'
# Server databases
gem 'mysql2', '~> 0.4.4'

###
### Assets
###

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0.2'
# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.2.1'
# Use bootstrap for styling
gem 'bootstrap', '~> 4.0.0.alpha4'
# Use font awesome for icons
gem 'font-awesome-rails', '~> 4.6.3.1'

###
### Models
###

# Validate email format without Regex
gem 'validates_email_format_of', '~> 1.6.3'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.11'

###
### Controllers and Application Logic
###

# Use respond_to in controller and respond_with
gem 'responders', '~> 2.3.0'

group :development, :test do
  ###
  ### Debugging
  ###

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.6', platform: :mri
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 3.3.1'
  # Replace rails default error pages
  gem 'better_errors', '~> 2.1.1'
  # Advanced features of better errors
  gem 'binding_of_caller', '~> 0.7.2'
  # Better printing of ruby objects
  gem 'awesome_print', '~> 1.7.0', require: 'ap'
  # View emails in dev environments
  gem 'letter_opener', '~> 1.4.1'

  ###
  ### Testing
  ###

  # Replace rails testing with rspec
  gem 'rspec-rails', '~> 3.5.2'
  # Create database objects during testing with ease
  gem 'factory_girl_rails', '~> 4.7.0'
  # Test the entire stack
  gem 'capybara', '~> 2.10.1'
  # Capybara can't run in a transaction because of AJAX
  gem 'database_cleaner', '~> 1.5.3'
  # Use FFaker for random value generation
  gem 'ffaker', '~> 2.2.0'

  ###
  ### Refactoring
  ###

  # Use rubocop to check style
  gem 'rubocop', '~> 0.44.1', require: false
  # Check style for tests
  gem 'rubocop-rspec', require: false
  # Use bullet to find performace issues
  gem 'bullet', '~> 5.4.2'

  ###
  ### Security
  ###

  # Audit the gemfile for insecure gems
  gem 'bundler-audit', '~> 0.5.0', require: false
  # Scan the application for vulnerabilities
  gem 'brakeman', '~> 3.4.0', require: false

  ###
  ### Utilitly
  ###

  # Watches the filesystem for changes
  gem 'listen', '~> 3.1.5'
  # Keep the application loaded in the background
  gem 'spring', '~> 2.0.0'
  # Update spring using listen
  gem 'spring-watcher-listen', '~> 2.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
