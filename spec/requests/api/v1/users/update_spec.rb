# frozen_string_literal: true

RSpec.describe 'API v1 User update', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }
  let(:resource) { create(:user, email: 'me@example.com') }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)
  end

  describe 'when resource is valid' do
    let(:parameters) do
      {
        username: 'michael'
      }
    end

    before do
      put "/api/v1/users/#{resource.username}", params: parameters, headers: default_headers
    end

    it 'returns 202 status' do
      expect(response).to have_http_status(:accepted)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:username]).to eq('michael')
    end
  end

  describe 'when resource is invalid' do
    let(:parameters) do
      {
        username: ''
      }
    end

    before do
      put "/api/v1/users/#{resource.username}", params: parameters, headers: default_headers
    end

    it 'returns 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns short error message' do
      expect(json_response[:errors][:username][:short]).to eq("can't be blank")
    end

    it 'returns long error message' do
      expect(json_response[:errors][:username][:long]).to eq("Username can't be blank")
    end
  end

  describe 'when no authorization token is sent' do
    before do
      put "/api/v1/users/#{resource.username}", headers: default_headers.except(:authorization)
    end

    it 'returns 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
