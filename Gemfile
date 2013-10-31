source 'https://rubygems.org'

gem "rails", "~> 4.0.0"

group :development do
	gem "sqlite3", "~> 1.3.8"

  # Preloading environment
  gem "guard-spork", "~> 1.5.1"
  gem "spork", "~> 1.0.0rc4"
end

group :test, :development do
  gem "debugger", "~> 1.6.1"
  gem "database_cleaner", "~> 1.2.0"
  # Cucumber (integration tests)
  gem "cucumber-rails", "~> 1.4.0", require: false
  gem "capybara", "~> 2.1.0"  
  # RSpec (unit tests, some integration tests)
  gem "rspec-rails", "~> 2.14.0"
  gem "shoulda-matchers", "~> 2.4.0"
  # Acceptance test
  gem 'webrat'
  # General helpers
  gem "factory_girl", "~> 4.2.0"
  gem "mocha", "~> 0.14.0", require: false
end


gem "haml", "~> 4.0.3"
gem "haml-rails"
# CSS
gem "sass-rails", "~> 4.0.0"
gem "sprockets"
gem "compass", "~> 0.12.2"
gem "compass-rails", github: "Compass/compass-rails", branch: "rails4-hack"
gem "zurb-foundation", "~> 4.3.2"

gem "uglifier", "~> 2.2.1"

# JS
gem "jquery-rails", "~> 3.0.4"
gem "coffee-rails", "~> 4.0.0"
# AngularJS related stuff
gem 'ng-rails-csrf', :git => "git://github.com/xrd/ng-rails-csrf.git"
gem "angularjs-rails", "~> 1.0.8"

gem "json"

gem "paperclip", "~> 3.0"



#Third party authentication
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem "omniauth-google-oauth2"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end