# frozen_string_literal: true

RSpec.describe 'API v1 Profile update', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user, first_name: 'Alison', last_name: 'Shepherd') }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is valid' do
    let(:parameters) do
      {
        first_name: 'Kate'
      }
    end

    before do
      put '/api/v1/profile', params: parameters, headers: default_headers
    end

    it 'returns 202 status' do
      expect(response).to have_http_status(:accepted)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:firstName]).to eq('Kate')
    end
  end

  describe 'when resource is invalid' do
    let(:parameters) do
      {
        first_name: ''
      }
    end

    before do
      put '/api/v1/profile', params: parameters, headers: default_headers
    end

    it 'returns 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns short error message' do
      expect(json_response[:errors][:first_name][:short]).to eq("can't be blank")
    end

    it 'returns long error message' do
      expect(json_response[:errors][:first_name][:long]).to eq("First Name can't be blank")
    end
  end

  describe 'when no authorization token is sent' do
    before do
      put '/api/v1/profile', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
