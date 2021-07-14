# frozen_string_literal: true

require 'simplecov'

SimpleCov.start :rails do
  add_group 'Inputs', 'app/inputs'
  add_group 'Modules', 'app/modules'
  add_group 'Policies', 'app/policies'
  add_group 'Services', 'app/services'
  add_group 'Validators', 'app/validators'
end

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'

require 'pry-byebug'
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
