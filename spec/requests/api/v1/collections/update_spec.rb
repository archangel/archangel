# frozen_string_literal: true

RSpec.describe 'API v1 Collection update', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }
  let(:resource) { create(:collection, site: site, name: 'My Collection') }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is valid' do
    let(:parameters) do
      {
        name: 'My Updated Collection'
      }
    end

    before do
      put "/api/v1/collections/#{resource.slug}", params: parameters, headers: default_headers
    end

    it 'returns 202 status' do
      expect(response).to have_http_status(:accepted)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('My Updated Collection')
    end
  end

  describe 'when resource is invalid' do
    let(:parameters) do
      {
        name: ''
      }
    end

    before do
      put "/api/v1/collections/#{resource.slug}", params: parameters, headers: default_headers
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
      put "/api/v1/collections/#{resource.slug}", headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
