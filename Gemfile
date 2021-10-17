# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.2'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootsnap', '>= 1.9.1', require: false
gem 'highline', '~> 2.0.3', require: false

gem 'bcrypt', '~> 3.1.16'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.5.0'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 6.1.4'
gem 'webpacker', '~> 5.4.3'

gem 'activerecord-typedstore', '~> 1.4.0'
gem 'acts_as_list', '~> 1.0.4'
gem 'cocoon', '~> 1.2.15'
gem 'devise', '~> 4.8.0'
gem 'devise_invitable', '~> 2.0.5'
gem 'discard', '~> 1.2.0'
gem 'image_processing', '~> 1.12.1'
gem 'jbuilder', '~> 2.11.2'
gem 'jwt', '~> 2.2.3'
gem 'kaminari', '~> 1.2.1'
gem 'oj', '~> 3.13.4'
gem 'pundit', '~> 2.1.1'
gem 'rabl', '~> 0.14.5'
gem 'rswag', '~> 2.4.0'
gem 'sidekiq', '~> 6.2.2'
gem 'simple_form', '~> 5.1.0'
gem 'turbolinks', '~> 5.2.1'

gem 'tzinfo-data', platforms: %i[jruby mingw mswin x64_mingw]

group :development do
  gem 'database_consistency', '~> 1.1.2', require: false

  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '~> 3.7.0'
  gem 'rack-mini-profiler', '~> 2.3.3'
  gem 'spring', '~> 3.0.0'
  gem 'web-console', '~> 4.1.0'
end

group :development, :test do
  gem 'rubocop', '~> 1.21.0', require: false
  gem 'rubocop-performance', '~> 1.11.5', require: false
  gem 'rubocop-rails', '~> 2.12.2', require: false
  gem 'rubocop-rspec', '~> 2.5.0', require: false

  gem 'brakeman', '~> 5.1.1'
  gem 'bullet', '~> 6.1.5'
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'i18n-tasks', '~> 0.9.34'
  gem 'pry-byebug', '~> 3.9.0'
end

group :test do
  gem 'capybara', '~> 3.35.3', require: false
  gem 'factory_bot_rails', '~> 6.2.0', require: false
  gem 'launchy', '~> 2.5.0'
  # gem 'pundit-matchers', '~> 1.6.0', require: false
  gem 'rspec_junit_formatter', '~> 0.4.1', require: false
  gem 'rspec-rails', '~> 5.0.2', require: false
  gem 'selenium-webdriver', '~> 3.142.7', require: false
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'webdrivers', '~> 4.6.1', require: false
  gem 'webmock', '~> 3.14.0', require: false
end
