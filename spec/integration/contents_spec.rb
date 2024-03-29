# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Contents API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:content) { create(:content, site: site) }
  let(:slug) { content.slug }
  let(:body) do
    {
      name: 'string',
      slug: 'string',
      body: 'string',
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

  path '/api/v1/contents' do
    get 'Content listing' do
      tags 'Contents'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, required: false, description: 'Page number of results'
      parameter name: :per_page, in: :query, type: :integer, required: false, description: 'Number of records for page'

      parameter name: :includes, in: :query, type: :string, required: false,
                enum: %w[stores],
                description: "Include associated data\n * `stores` Store data\n"

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/contents'

        let(:contents) { create_list(:content, 3, site: site) }

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' } # rubocop:disable RSpec/VariableName

        run_test!
      end
    end

    post 'Create a content' do
      tags 'Contents'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %w[name slug],
        properties: {
          name: { type: :string },
          slug: { type: :string },
          body: { type: :string },
          published_at: {
            type: :string,
            nullable: true
          }
        }
      }

      response '201', 'created' do
        schema '$ref' => '#/components/schemas/content'

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
            body: '',
            published_at: ''
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/contents/{slug}' do
    get 'Retrieve a content' do
      tags 'Contents'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string

      parameter name: :includes, in: :query, type: :string, required: false,
                enum: %w[stores],
                description: "Include associated data\n * `stores` Store data\n"

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/content'

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

    put 'Update a content' do
      tags 'Contents'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :slug, in: :path, type: :string
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          slug: { type: :string },
          body: { type: :string },
          published_at: {
            type: :string,
            nullable: true
          }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/content'

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
            body: '',
            published_at: ''
          }
        end

        run_test!
      end
    end

    delete 'Delete a content' do
      tags 'Contents'
      description 'Initially a soft delete. Hard delete when called a second time'
      security [Bearer: [], Subdomain: []]
      consumes 'application/json'
      produces 'application/json'

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

    path '/api/v1/contents/{slug}/restore' do
      post 'Restore a content' do
        tags 'Contents'
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
