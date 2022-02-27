# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Collections API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:collection) { create(:collection, site: site) }
  let(:slug) { collection.slug }
  let(:body) do
    {
      name: 'string',
      slug: 'string',
      published_at: 'string'
    }
  end

  let(:Authorization) { profile.auth_token } # rubocop:disable RSpec/VariableName
  let(:'X-Archangel-Site') { site.subdomain } # rubocop:disable RSpec/VariableName
  let(:page) { 1 }
  let(:per_page) { 24 }

  before do
    create(:user_site, user: profile, site: site)
  end

  path '/api/v1/collections' do
    get 'Collection listing' do
      tags 'Collections'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, description: 'Page number of results'
      parameter name: :per_page, in: :query, type: :integer, description: 'Number of records for page'

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/collections'

        let(:collections) { create_list(:collection, 3, site: site) }

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end

    post 'Create a collection' do
      tags 'Collections'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %w[name slug],
        properties: {
          name: { type: :string },
          slug: { type: :string },
          published_at: {
            type: :string,
            nullable: true
          }
        }
      }

      response '201', 'created' do
        schema '$ref' => '#/components/schemas/collection'

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
            slug: '',
            published_at: ''
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/collections/{slug}' do
    get 'Retrieve a collection' do
      tags 'Collections'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/collection'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:slug) { 'unknown' }

        run_test!
      end
    end

    put 'Update a collection' do
      tags 'Collections'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          slug: { type: :string },
          published_at: {
            type: :string,
            nullable: true
          }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/collection'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:slug) { 'unknown' }

        run_test!
      end

      response '422', 'unprocessable' do
        schema '$ref' => '#/components/schemas/unprocessable'

        let(:body) do
          {
            name: '',
            slug: '',
            published_at: ''
          }
        end

        run_test!
      end
    end

    delete 'Delete a collection' do
      tags 'Collections'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'

      parameter name: :slug, in: :path, type: :string

      response '204', 'no content' do
        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end

    path '/api/v1/collections/{slug}/restore' do
      post 'Restore a collection' do
        tags 'Collections'
        security [Bearer: [], Subdomain: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :slug, in: :path, type: :string

        response '202', 'accepted' do
          run_test!
        end

        response '401', 'unauthorized' do
          schema '$ref' => '#/components/schemas/unauthorized'

          let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

          run_test!
        end

        response '404', 'not found' do
          schema '$ref' => '#/components/schemas/not_found'

          let(:slug) { 'unknown' }

          run_test!
        end
      end
    end
  end
end
