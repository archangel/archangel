# frozen_string_literal: true

RSpec.describe 'API v1 Profile detail', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user, first_name: 'Alison', last_name: 'Shepherd') }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'with resource' do
    before do
      get '/api/v1/profile', headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('Alison Shepherd')
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/profiles/show')
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/profile', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
