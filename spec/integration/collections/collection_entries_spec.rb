# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Collection Entries API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:collection_fields) do
    [
      build(:collection_field, :string, label: 'First Field', key: 'field1', required: true),
      build(:collection_field, :string, label: 'Second Field', key: 'field2')
    ]
  end
  let(:collection) { create(:collection, site: site, collection_fields: collection_fields) }
  let(:slug) { collection.slug }
  let(:entry) { create(:collection_entry, collection: collection, content: { field1: 'Field 1', field2: 'Field 2' }) }
  let(:id) { entry.id }
  let(:body) do
    {
      field1: 'string',
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

  path '/api/v1/collections/{slug}/entries' do
    get 'Collection Entry listing' do
      tags 'Collection Entries'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string
      parameter name: :page, in: :query, type: :integer, description: 'Page number of results'
      parameter name: :per_page, in: :query, type: :integer, description: 'Number of records for page'

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/collection_entries'

        let(:collection_entries) do
          create_list(:collection_entry, 3, collection: collection, content: { name: 'Entry Name', slug: 'entrySlug' })
        end

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end

    post 'Create a collection entry' do
      tags 'Collection Entries'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          published_at: {
            type: :string,
            nullable: true
          }
        }
      }

      response '201', 'created' do
        schema '$ref' => '#/components/schemas/collection_entry'

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
            first: ''
          }
        end

        run_test!
      end
    end

    path '/api/v1/collections/{slug}/entries/reposition' do
      post 'Reposition collection entries' do
        tags 'Collection Entries'
        security [Bearer: [], Subdomain: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :slug, in: :path, type: :string
        parameter name: :body, in: :body, schema: {
          type: :object,
          required: %w[positions],
          properties: {
            positions: {
              type: :array,
              items: {
                type: :integer
              }
            }
          }
        }

        response '202', 'accepted' do
          let(:body) do
            {
              positions: []
            }
          end

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

  path '/api/v1/collections/{slug}/entries/{id}' do
    get 'Retrieve a collection entry' do
      tags 'Collection Entries'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string
      parameter name: :id, in: :path, type: :integer

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/collection_entry'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:id) { 0 }

        run_test!
      end
    end

    put 'Update a collection entry' do
      tags 'Collection Entries'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string
      parameter name: :id, in: :path, type: :integer
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          published_at: {
            type: :string,
            nullable: true
          }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/collection_entry'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:id) { 0 }

        run_test!
      end

      response '422', 'unprocessable' do
        schema '$ref' => '#/components/schemas/unprocessable'

        let(:body) do
          {
            field1: '',
            published_at: ''
          }
        end

        run_test!
      end
    end

    delete 'Delete a collection entry' do
      tags 'Collection Entries'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'

      parameter name: :slug, in: :path, type: :string
      parameter name: :id, in: :path, type: :integer

      response '204', 'no content' do
        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end

    path '/api/v1/collections/{slug}/entries/{id}/restore' do
      post 'Restore a collection entry' do
        tags 'Collection Entries'
        security [Bearer: [], Subdomain: []]
        consumes 'application/json'
        produces 'application/json'

        parameter name: :slug, in: :path, type: :string
        parameter name: :id, in: :path, type: :integer

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

          let(:id) { 0 }

          run_test!
        end
      end
    end
  end
end
