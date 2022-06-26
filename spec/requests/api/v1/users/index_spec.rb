# frozen_string_literal: true

RSpec.describe 'API v1 User listing', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'with default options' do
    before do
      ('a'..'z').each do |letter|
        user = create(:user, username: "username-#{letter}")
        create(:user_site, user: user, site: site)
      end

      get '/api/v1/users', headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns items in default order (name asc)' do
      expected_response = ('a'..'x').map { |letter| "username-#{letter}" }

      expect(json_response[:data].pluck(:username)).to eq(expected_response)
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/users/index')
    end
  end

  describe 'with sorting' do
    before do
      ('a'..'c').each do |letter|
        user = create(:user, username: "username-#{letter}")
        create(:user_site, user: user, site: site)
      end
    end

    describe 'with username sorting' do
      it 'sorts by username asc' do
        get '/api/v1/users', params: { sort: 'username' }, headers: default_headers

        expect(json_response[:data].pluck(:username)).to eq(%w[username-a username-b username-c])
      end

      it 'sorts by username desc' do
        get '/api/v1/users', params: { sort: '-username' }, headers: default_headers

        expect(json_response[:data].pluck(:username)).to eq(%w[username-c username-b username-a])
      end
    end
  end

  describe 'with pagination' do
    before do
      ('a'..'z').each do |letter|
        user = create(:user, username: "username-#{letter}")
        create(:user_site, user: user, site: site)
      end
    end

    it 'returns the second page of results' do
      get '/api/v1/users', params: { page: 2, per_page: 2 }, headers: default_headers

      expect(json_response[:data].pluck(:username)).to eq(['username-c', 'username-d'])
    end

    it 'finds nothing outside the count' do
      get '/api/v1/users', params: { page: 2, per_page: 26 }, headers: default_headers

      expect(json_response[:data].pluck(:username)).to eq([])
    end
  end

  describe 'when no resources are found' do
    before do
      get '/api/v1/users', headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns an empty array' do
      expect(json_response[:data].size).to eq(0)
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/users', headers: default_headers.except(:authorization)
    end

    it 'returns 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
