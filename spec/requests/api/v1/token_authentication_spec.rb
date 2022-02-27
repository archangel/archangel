# frozen_string_literal: true

RSpec.describe 'API v1 token authentication', type: :request, skip: true do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:content, site: site) }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when `auth_token` is not provided' do
    before do
      get "/api/v1/contents/#{resource.slug}",
          headers: { accept: 'application/json' }
    end

    it 'returns correct status (401)' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns correct message' do
      expect(json_response[:message]).to eq('Authorization token is missing')
    end
  end

  describe 'when `auth_token` is blank' do
    before do
      get "/api/v1/contents/#{resource.slug}",
          headers: { accept: 'application/json', authorization: '' }
    end

    it 'returns correct status (401)' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns correct message' do
      expect(json_response[:message]).to eq('Authorization token is missing')
    end
  end

  describe 'when invalid `auth_token` is provided' do
    before do
      get "/api/v1/contents/#{resource.slug}",
          headers: { accept: 'application/json', authorization: 'not-a-real-auth-token' }
    end

    it 'returns correct status (401)' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns correct message' do
      expect(json_response[:message]).to eq('Invalid authorization token')
    end
  end
end
