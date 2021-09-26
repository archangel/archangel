# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Auths API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:access_token) { user.auth_token }

  before do
    create(:user_site, user: profile, site: site)
  end

  path '/api/v1/auth' do
    post 'Retrieve authentication token' do
      tags 'Auth'
      security []
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %w[email password],
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/auth_create'

        let(:body) { { email: profile.email, password: profile.password } }

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:body) { { email: '', password: '' } }

        run_test!
      end
    end
  end
end
