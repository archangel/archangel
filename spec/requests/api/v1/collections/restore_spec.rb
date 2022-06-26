# frozen_string_literal: true

RSpec.describe 'API v1 Collection restore', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }
  let(:resource) { create(:collection, :discarded, site: site, name: 'My Discarded Collection') }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is valid' do
    before do
      post "/api/v1/collections/#{resource.slug}/restore", headers: default_headers
    end

    it 'returns 202 status' do
      expect(response).to have_http_status(:accepted)
    end

    it 'does not return a body' do
      expect(response.body).to be_empty
    end
  end

  describe 'when resource does not exist' do
    before do
      post '/api/v1/collections/0000/restore', headers: default_headers
    end

    it 'returns 404 status' do
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'when no authorization token is sent' do
    before do
      post "/api/v1/collections/#{resource.slug}/restore", headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
