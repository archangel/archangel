# frozen_string_literal: true

RSpec.describe 'API v1 Collection listing', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:access_token) { profile.auth_token }
  let(:resource) { create(:collection, site: site) }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when Collections are found' do
    before do
      create(:collection, site: site, name: 'Work')
      create(:collection, site: site, name: 'Personal')
      create(:collection, :discarded, site: site, name: 'Deleted')

      get '/api/v1/collections',
          headers: { accept: 'application/json', authorization: access_token }
    end

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns in specified order by `position`' do
      expect(json_response[:data][0][:name]).to eq('Personal')
    end

    it 'does not return soft deleted items' do
      expect(json_response[:data].size).to eq(2)
    end
  end

  describe 'when no Collections are found' do
    before do
      get '/api/v1/collections',
          headers: { accept: 'application/json', authorization: access_token }
    end

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns an empty array' do
      expect(json_response[:data].size).to eq(0)
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/collections',
          headers: { accept: 'application/json' }
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
