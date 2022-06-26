# frozen_string_literal: true

RSpec.describe 'API v1 Site update', type: :request do
  let(:site) { create(:site, name: 'My Site') }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is valid' do
    let(:parameters) do
      {
        name: 'My Updated Site'
      }
    end

    before do
      put '/api/v1/site', params: parameters, headers: default_headers
    end

    it 'returns 202 status' do
      expect(response).to have_http_status(:accepted)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('My Updated Site')
    end
  end

  describe 'when resource is invalid' do
    let(:parameters) do
      {
        name: ''
      }
    end

    before do
      put '/api/v1/site', params: parameters, headers: default_headers
    end

    it 'returns 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns short error message' do
      expect(json_response[:errors][:name][:short]).to eq("can't be blank")
    end

    it 'returns long error message' do
      expect(json_response[:errors][:name][:long]).to eq("Name can't be blank")
    end
  end

  describe 'when no authorization token is sent' do
    before do
      put '/api/v1/site', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
