# frozen_string_literal: true

RSpec.configure do |config|
  if Bullet.enable?
    config.before { Bullet.start_request }
    config.after { Bullet.end_request }
  end

  ##
  # Disable Bullet for example
  #
  # Disable Bullet for specific examples, contexts or runner. Bullet will be re-enabled after the example runs.
  #
  # Example
  #   # For entire test
  #   RSpec.describe 'Something', type: :system, bullet: false do
  #     ...
  #   end
  #
  #   For entire context
  #   describe 'when doing something', bullet: false do
  #     ...
  #   end
  #
  #   For single example
  #   it 'does something', bullet: false do
  #     ...
  #   end
  #
  config.around(:each, bullet: false) do |example|
    config.mock_with :rspec do |_mocks|
      previous_value = Bullet.enable?
      Bullet.enable = false
      example.run
      Bullet.enable = previous_value
    end
  end
end
