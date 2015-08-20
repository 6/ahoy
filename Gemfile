source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem "omniauth-google-oauth2"
gem 'haml-rails'
gem 'unicorn'
# This fork works with bootstrap-sass
gem 'bootstrap-generators', git: 'https://github.com/kuroneko/bootstrap-generators.git'
gem 'email_validator'
gem 'twilio-ruby'
gem 'bootstrap-sass'
gem 'mail'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'andand'
gem 'rollbar'
gem 'react-rails'

group :development, :test do
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-nc'
  gem 'factory_girl_rails'
end

group :test do
  gem 'webmock'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :development do
  gem 'quiet_assets'
end

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end
