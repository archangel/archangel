# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Profiles API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:Authorization) { profile.auth_token } # rubocop:disable RSpec/VariableName
  let(:'X-Archangel-Site') { site.subdomain } # rubocop:disable RSpec/VariableName

  before do
    create(:user_site, user: profile, site: site)
  end

  path '/api/v1/profile' do
    get 'Retrieve profile' do
      tags 'Profile'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/profile'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end

    put 'Update profile' do
      tags 'Profile'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          username: { type: :string },
          first_name: { type: :string },
          last_name: {
            type: :string,
            nullable: true
          }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/profile'

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
            email: '',
            password: '',
            password_confirmation: '',
            username: '',
            first_name: '',
            last_name: ''
          }
        end

        run_test!
      end
    end

    path '/api/v1/profile/permissions' do
      get 'Profile permissions' do
        tags 'Profile'
        security [Bearer: [], Subdomain: []]
        consumes 'application/json'
        produces 'application/json'

        response '200', 'success' do
          schema '$ref' => '#/components/schemas/profile_permission'

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
end
