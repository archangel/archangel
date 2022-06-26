# frozen_string_literal: true

RSpec.describe 'API v1 User detail', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }
  let(:resource) { create(:user, email: 'me@example.com') }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)
  end

  describe 'when resource is found' do
    before do
      get "/api/v1/users/#{resource.username}", headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:email]).to eq('me@example.com')
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/users/show')
    end
  end

  describe 'when resource is not found' do
    before do
      get '/api/v1/users/unknown', headers: default_headers
    end

    it 'returns 404 status' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error message' do
      expect(json_response[:message]).to eq('User not found')
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/users/unknown', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
