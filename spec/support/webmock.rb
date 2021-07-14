# frozen_string_literal: true

require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:suite) do
    WebMock.disable_net_connect!(
      allow_localhost: true,
      allow: [
        /chromedriver\.storage\.googleapis\.com/,
        %r{github.com/mozilla/geckodriver/releases}
      ]
    )
  end

  config.after { WebMock.reset! }
end
