# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.3'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootsnap', '>= 1.10.3', require: false
gem 'highline', '~> 2.0.3', require: false

gem 'bcrypt', '~> 3.1.16'
gem 'nokogiri', '~> 1.13.3'
gem 'pg', '~> 1.3.1'
gem 'puma', '~> 5.6.2'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 6.1.4'
gem 'webpacker', '~> 5.4.3'

gem 'activerecord-typedstore', '~> 1.4.0'
gem 'acts_as_list', '~> 1.0.4'
gem 'cocoon', '~> 1.2.15'
gem 'devise', '~> 4.8.1'
gem 'devise_invitable', '~> 2.0.6'
gem 'discard', '~> 1.2.1'
gem 'image_processing', '~> 1.12.1'
gem 'jbuilder', '~> 2.11.5'
gem 'jwt', '~> 2.3.0'
gem 'kaminari', '~> 1.2.2'
gem 'oj', '~> 3.13.11'
gem 'pundit', '~> 2.2.0'
gem 'rabl', '~> 0.15.0'
gem 'rswag', '~> 2.5.1'
gem 'show_for', '~> 0.8.0'
gem 'sidekiq', '~> 6.4.1'
gem 'simple_form', '~> 5.1.0'
gem 'toller', '~> 0.5.0'
gem 'turbolinks', '~> 5.2.1'
gem 'validates_timeliness', '~> 6.0.0.beta2'

gem 'tzinfo-data', platforms: %i[jruby mingw mswin x64_mingw]

group :development do
  gem 'database_consistency', '~> 1.1.12', require: false

  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '~> 3.7.1'
  gem 'rack-mini-profiler', '~> 2.3.3'
  gem 'spring', '~> 4.0.0'
  gem 'web-console', '~> 4.2.0'
end

group :development, :test do
  gem 'rubocop', '~> 1.25.1', require: false
  gem 'rubocop-performance', '~> 1.13.2', require: false
  gem 'rubocop-rails', '~> 2.13.2', require: false
  gem 'rubocop-rspec', '~> 2.8.0', require: false

  gem 'brakeman', '~> 5.2.1'
  gem 'bullet', '~> 7.0.1'
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'i18n-tasks', '~> 0.9.37'
  gem 'pry-byebug', '~> 3.9.0'
end

group :test do
  gem 'capybara', '~> 3.36.0', require: false
  gem 'factory_bot_rails', '~> 6.2.0', require: false
  gem 'launchy', '~> 2.5.0', require: false
  gem 'pundit-matchers', '~> 1.7.0', require: false
  gem 'rspec_junit_formatter', '~> 0.5.1', require: false
  gem 'rspec-rails', '~> 5.1.0', require: false
  gem 'selenium-webdriver', '~> 4.1.0', require: false
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'webdrivers', '~> 5.0.0', require: false
  gem 'webmock', '~> 3.14.0', require: false
end
