# frozen_string_literal: true

RSpec.describe 'API v1 User create', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user, email: 'me@example.com') }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is valid' do
    let(:parameters) do
      {
        email: 'me@example.com',
        first_name: 'John',
        last_name: 'Doe',
        username: 'johndoe'
      }
    end

    before do
      post '/api/v1/users', params: parameters, headers: default_headers
    end

    it 'returns 201 status' do
      expect(response).to have_http_status(:created)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:email]).to eq('me@example.com')
    end
  end

  describe 'when resource is invalid' do
    let(:parameters) do
      {
        email: '',
        first_name: '',
        last_name: '',
        username: ''
      }
    end

    before do
      post '/api/v1/users', params: parameters, headers: default_headers
    end

    it 'returns 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns correct short error' do
      expect(json_response[:errors][:email][:short]).to eq("can't be blank")
    end

    it 'returns correct long error' do
      expect(json_response[:errors][:email][:long]).to eq("Email can't be blank")
    end
  end

  describe 'when no authorization token is sent' do
    before do
      post '/api/v1/users', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
