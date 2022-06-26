# frozen_string_literal: true

require 'json_schemer'
require 'pathname'

# Match JSON schema
#
# @example Usage
#   # In spec test
#   get '/api/v1/examples', headers: { accept: 'application/json' }
#   # Schema file should be in spec/fixtures/schemas/json/examples/index.json
#   expect(response).to match_json_schema('json/examples/index')
RSpec::Matchers.define :match_json_schema do |schema|
  match do |response|
    schema_path = "#{Dir.pwd}/spec/fixtures/schemas/#{schema}.json"
    schema = Pathname.new(schema_path)
    json_parsed_body = JSON.parse(response.body)

    JSONSchemer.schema(schema).validate(json_parsed_body)
  end
end
