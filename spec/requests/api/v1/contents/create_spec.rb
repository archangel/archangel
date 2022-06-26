# frozen_string_literal: true

RSpec.describe 'API v1 Content create', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is valid' do
    let(:parameters) do
      {
        name: 'My New Content',
        slug: 'my-new-content',
        body: 'Body of the content'
      }
    end

    before do
      post '/api/v1/contents', params: parameters, headers: default_headers
    end

    it 'returns 201 status' do
      expect(response).to have_http_status(:created)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('My New Content')
    end
  end

  describe 'when resource is invalid' do
    let(:parameters) do
      {
        name: '',
        slug: '',
        body: ''
      }
    end

    before do
      post '/api/v1/contents', params: parameters, headers: default_headers
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
      post '/api/v1/contents', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
