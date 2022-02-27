# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Users API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:user) { create(:user) }
  let(:username) { user.username }
  let(:body) do
    {
      email: 'me@example.com',
      username: 'string',
      first_name: 'string',
      last_name: 'string'
    }
  end

  let(:Authorization) { profile.auth_token }
  let(:'X-Archangel-Site') { site.subdomain }
  let(:page) { 1 }
  let(:per_page) { 24 }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: user, site: site)
  end

  path '/api/v1/users' do
    get 'User listing' do
      tags 'Users'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, description: 'Page number of results'
      parameter name: :per_page, in: :query, type: :integer, description: 'Number of records for page'

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/users'

        let(:users) do
          users = create_list(:users, 3, site: site)

          users.each do |user|
            create(:user_site, user: user, site: site)
          end

          users
        end

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end
    end

    post 'Create a user' do
      tags 'Users'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %w[email username first_name],
        properties: {
          email: { type: :string },
          role: { type: :string },
          username: { type: :string },
          first_name: { type: :string },
          last_name: {
            type: :string,
            nullable: true
          }
        }
      }

      response '201', 'created' do
        schema '$ref' => '#/components/schemas/user'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '422', 'unprocessable' do
        schema '$ref' => '#/components/schemas/unprocessable'

        let(:body) do
          {
            email: '',
            username: '',
            first_name: '',
            last_name: ''
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/users/{username}' do
    get 'Retrieve a user' do
      tags 'Users'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :username, in: :path, type: :string

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/user'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:username) { 'unknown' }

        run_test!
      end
    end

    put 'Update a user' do
      tags 'Users'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :username, in: :path, type: :string
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          role: { type: :string },
          username: { type: :string },
          first_name: { type: :string },
          last_name: {
            type: :string,
            nullable: true
          }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/user'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:username) { 'unknown' }

        run_test!
      end

      response '422', 'unprocessable' do
        schema '$ref' => '#/components/schemas/unprocessable'

        let(:body) do
          {
            email: '',
            username: '',
            first_name: '',
            last_name: ''
          }
        end

        run_test!
      end
    end

    delete 'Delete a user' do
      tags 'Users'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'

      parameter name: :username, in: :path, type: :string

      response '204', 'no content' do
        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end
    end
  end

  path '/api/v1/users/{username}/unlock' do
    post 'Unlock a user' do
      tags 'Users'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :username, in: :path, type: :string

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/user'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:username) { 'unknown' }

        run_test!
      end
    end
  end
end
