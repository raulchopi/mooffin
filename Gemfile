source 'https://rubygems.org'
ruby '2.1.1'

gem "rails", "~> 4.1.1"

group :development do
	gem "sqlite3", "~> 1.3.9"

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
  gem 'minitest', '~> 5.3.4'
  gem "rspec-rails", "~> 2.14.0"
  gem "shoulda-matchers", "~> 2.4.0"
  # Acceptance test
  gem 'webrat', '~> 0.7.3'
  # General helpers
  gem "factory_girl", "~> 4.2.0"
  gem "mocha", "~> 0.14.0", require: false
end

group :production do
  gem 'pg', '~> 0.17.1'
  # gem 'rails_12factor', '0.0.2'
end

#Bower manage our assets
gem 'bower-rails'

gem "log4r", "~> 1.1.10"

gem "haml", "~> 4.0.3"
gem 'haml-rails', '~> 0.5.3'
# CSS
gem "sass-rails", "~> 4.0.3"
gem "sprockets", "~> 2.11.0"
gem 'compass-rails', '~> 1.1.7'
gem "zurb-foundation", "~> 4.3.2"

gem "uglifier", "~> 2.2.1"

# JS
gem "jquery-rails", "~> 3.1.0"
gem "coffee-rails", "~> 4.0.1"
gem 'select2-rails', '~> 3.5.9.1'

gem 'json', '~> 1.8.1'

gem "paperclip", "~> 4.2"

gem 'sorcery', '~> 0.8.5'
#Third party authentication
gem 'devise', '~> 3.2.4'
gem 'omniauth-facebook', '~> 1.6.0'
gem 'omniauth-twitter', '~> 1.0.1'
gem 'omniauth-google-oauth2', '~> 0.2.4'

gem 'friendly_id', '~> 5.1.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'pin_it', '~> 0.0.7'

gem 'rack-cors', :require => 'rack/cors'

gem 'ng-rails-csrf'

gem 'ionicons-rails'

# panel de administracion
gem 'rails_admin'

gem "easy_roles", "~> 1.2.0"

# generador de sitemap
gem "dynamic_sitemaps"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
