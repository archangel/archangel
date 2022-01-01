# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Collections API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:collection) { create(:collection, site: site) }
  let(:collectionSlug) { collection.slug }
  let(:body) do
    {
      name: 'string',
      slug: 'string',
      published_at: 'string'
    }
  end
  let(:Authorization) { profile.auth_token }

  before do
    create(:user_site, user: profile, site: site)
  end

  path '/api/v1/collections' do
    get 'Collection listing' do
      tags 'Collections'
      security [Bearer: {}]
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/collections'

        let(:collections) { create_list(:collection, 3, site: site) }

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end
    end

    post 'Create a collection' do
      tags 'Collections'
      security [Bearer: {}]
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

        let(:Authorization) { '' }

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

  path '/api/v1/collections/{collectionSlug}' do
    get 'Retrieve a collection' do
      tags 'Collections'
      security [Bearer: {}]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :collectionSlug, in: :path, type: :string

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/collection'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:collectionSlug) { 'unknown' }

        run_test!
      end
    end

    put 'Update a collection' do
      tags 'Collections'
      security [Bearer: {}]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :collectionSlug, in: :path, type: :string
      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %w[name],
        properties: {
          name: { type: :string }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/collection'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:collectionSlug) { 'unknown' }

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
      security [Bearer: {}]
      consumes 'application/json'

      parameter name: :collectionSlug, in: :path, type: :string

      response '204', 'no collection' do
        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end
    end
  end
end
