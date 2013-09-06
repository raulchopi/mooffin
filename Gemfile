source 'https://rubygems.org'

gem "rails", "~> 4.0.0"

group :development do
	gem "sqlite3", "~> 1.3.8"
end

group :test, :development do
  gem "rspec-rails", "~> 2.14.0"
  gem 'webrat'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem "sass-rails", "~> 4.0.0"
	gem "haml", "~> 4.0.3"
	gem "coffee-rails", "~> 4.0.0"
	gem "uglifier", "~> 2.2.1"
end

gem "jquery-rails", "~> 3.0.4"

# we don't call the group :test because we don't want them auto-required
group :testing do
	gem "cucumber-rails", "~> 1.4.0"
	gem "factory_girl", "~> 4.2.0"
end

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end