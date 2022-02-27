# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Sessions API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:'X-Archangel-Site') { site.subdomain } # rubocop:disable RSpec/VariableName

  before do
    create(:user_site, user: profile, site: site)
  end

  path '/api/v1/session' do
    post 'Log in' do
      tags 'Session'
      security [Subdomain: []]
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
        schema '$ref' => '#/components/schemas/session'

        let(:body) { { email: profile.email, password: profile.password } }

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:body) { { email: profile.email, password: '' } }

        run_test!
      end
    end

    delete 'Log out' do
      tags 'Session'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      response '204', 'no_content' do
        let(:Authorization) { profile.auth_token } # rubocop:disable RSpec/VariableName

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end
  end
end
