# frozen_string_literal: true

RSpec.describe 'API v1 Content detail', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }
  let(:resource) { create(:content, site: site, name: 'My Content') }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is found' do
    before do
      get "/api/v1/contents/#{resource.slug}", headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('My Content')
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/contents/show')
    end
  end

  describe 'with includes' do
    before do
      resource.update(stores: build_list(:store, 3, :for_content))
    end

    it 'returns all Stores for resource' do
      get "/api/v1/contents/#{resource.slug}", params: { includes: 'stores' },
                                               headers: default_headers

      expect(json_response[:data][:stores].size).to eq(3)
    end

    it 'does not return Stores key without includes' do
      get "/api/v1/contents/#{resource.slug}", headers: default_headers

      expect(json_response[:data].keys).not_to include(:stores)
    end
  end

  describe 'when resource is not found' do
    before do
      get '/api/v1/contents/0000', headers: default_headers
    end

    it 'returns 404 status' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error message' do
      expect(json_response[:message]).to eq('Content not found')
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/contents/1234', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
