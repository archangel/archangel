# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Contents API' do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:access_token) { user.auth_token }
  let(:content) { create(:content, site: site) }
  let(:contentSlug) { content.slug }
  let(:body) do
    {
      name: 'string',
      slug: 'string',
      body: 'string',
      published_at: 'string'
    }
  end
  let(:Authorization) { profile.auth_token }

  before do
    create(:user_site, user: profile, site: site)
  end

  path '/api/v1/contents' do
    get 'Content listing' do
      tags 'Contents'
      security [Bearer: {}]
      consumes 'application/json'
      produces 'application/json'

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/contents'

        let(:contents) { create_list(:content, 3, site: site) }

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end
    end

    post 'Create a content' do
      tags 'Contents'
      security [Bearer: {}]
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

        let(:Authorization) { '' }

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

  path '/api/v1/contents/{contentSlug}' do
    get 'Retrieve a content' do
      tags 'Contents'
      security [Bearer: {}]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :contentSlug, in: :path, type: :string

      response '200', 'success' do
        schema '$ref' => '#/components/schemas/content'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:contentSlug) { 'unknown' }

        run_test!
      end
    end

    put 'Update a content' do
      tags 'Contents'
      security [Bearer: {}]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :contentSlug, in: :path, type: :string
      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %w[name],
        properties: {
          name: { type: :string }
        }
      }

      response '202', 'accepted' do
        schema '$ref' => '#/components/schemas/content'

        run_test!
      end

      response '401', 'unauthorized' do
        schema '$ref' => '#/components/schemas/unauthorized'

        let(:Authorization) { '' }

        run_test!
      end

      response '404', 'not found' do
        schema '$ref' => '#/components/schemas/not_found'

        let(:contentSlug) { 'unknown' }

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
      security [Bearer: {}]
      consumes 'application/json'

      parameter name: :contentSlug, in: :path, type: :string

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
end
