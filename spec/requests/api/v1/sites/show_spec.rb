# frozen_string_literal: true

RSpec.describe 'API v1 Site detail', type: :request do
  let(:site) { create(:site, name: 'My Site') }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'with resource' do
    before do
      get '/api/v1/site', headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('My Site')
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/sites/show')
    end
  end

  describe 'with includes' do
    before do
      site.update(stores: build_list(:store, 3, :for_site))
    end

    it 'returns all Stores for resource' do
      get '/api/v1/site', params: { includes: 'stores' }, headers: default_headers

      expect(json_response[:data][:stores].size).to eq(3)
    end

    it 'does not return Stores key without includes' do
      get '/api/v1/site', headers: default_headers

      expect(json_response[:data].keys).not_to include(:stores)
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/site', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
