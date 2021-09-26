# frozen_string_literal: true

module Archangel
  module TestingSupport
    module JsonResponseHelpers
      def json_response
        @json_response ||= JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end

RSpec.configure do |config|
  %i[request system].each do |type|
    config.include Archangel::TestingSupport::JsonResponseHelpers, type: type
  end
end
