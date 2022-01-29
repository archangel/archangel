# frozen_string_literal: true

RSpec.describe 'API v1 Collection detail', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:access_token) { profile.auth_token }
  let(:resource) { create(:collection, site: site, name: 'My Collection') }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when Collection is found' do
    before do
      get "/api/v1/collections/#{resource.slug}",
          headers: { accept: 'application/json', authorization: access_token }
    end

    it 'returns correct status (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('My Collection')
    end
  end

  describe 'when Collection is not found' do
    before do
      get '/api/v1/collections/000000000',
          headers: { accept: 'application/json', authorization: access_token }
    end

    it 'returns correct status (404)' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns correct resource' do
      expect(json_response[:message]).to eq('Collection not found')
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/collections/000000000',
          headers: { accept: 'application/json' }
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
