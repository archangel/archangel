# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Sites API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:body) do
    {
      name: 'string',
      subdomain: 'string'
    }
  end

  let(:Authorization) { profile.auth_token } # rubocop:disable RSpec/VariableName
  let(:'X-Archangel-Site') { site.subdomain } # rubocop:disable RSpec/VariableName

  before do
    create(:user_site, user: profile, site: site)
  end

  path '/api/v1/site' do
    get 'Retrieve a site' do
      tags 'Site'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :includes, in: :query, type: :string, required: false,
                enum: %w[stores],
                description: "Include associated data\n * `stores` Store data\n"

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/site'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end

    put 'Update a site' do
      tags 'Site'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %w[name subdomain],
        properties: {
          name: { type: :string },
          subdomain: { type: :string },
          format_date: { type: :string },
          format_datetime: { type: :string },
          format_time: { type: :string },
          format_js_date: { type: :string },
          format_js_datetime: { type: :string },
          format_js_time: { type: :string },
          regenerate_auth_token_on_login: { type: :boolean },
          regenerate_auth_token_on_logout: { type: :boolean }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/site'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end

      response '422', 'unprocessable' do
        schema '$ref' => '#/components/schemas/unprocessable'

        let(:body) do
          {
            name: '',
            subdomain: ''
          }
        end

        run_test!
      end
    end
  end
end
