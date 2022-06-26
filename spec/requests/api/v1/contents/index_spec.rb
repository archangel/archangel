# frozen_string_literal: true

RSpec.describe 'API v1 Content listing', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'with default options' do
    before do
      ('A'..'Z').each { |letter| create(:content, site: site, name: "Content #{letter} Name") }

      get '/api/v1/contents', headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns items in default order (name asc)' do
      expected_response = ('A'..'X').map { |letter| "Content #{letter} Name" }

      expect(json_response[:data].pluck(:name)).to eq(expected_response)
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/contents/index')
    end
  end

  describe 'with sorting' do
    before do
      ('A'..'C').each do |letter|
        create(:content, site: site, name: "Content #{letter} Name", slug: "slug_#{letter.downcase}")
      end
    end

    describe 'with name sorting' do
      it 'sorts by name asc' do
        get '/api/v1/contents', params: { sort: 'name' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Content A Name', 'Content B Name', 'Content C Name'])
      end

      it 'sorts by name desc' do
        get '/api/v1/contents', params: { sort: '-name' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Content C Name', 'Content B Name', 'Content A Name'])
      end
    end

    describe 'with slug sorting' do
      it 'sorts by slug asc' do
        get '/api/v1/contents', params: { sort: 'slug' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Content A Name', 'Content B Name', 'Content C Name'])
      end

      it 'sorts by slug desc' do
        get '/api/v1/contents', params: { sort: '-slug' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Content C Name', 'Content B Name', 'Content A Name'])
      end
    end
  end

  describe 'with includes' do
    before do
      create(:content, site: site, name: 'Content A Name', stores: build_list(:store, 3, :for_content))
      create(:content, site: site, name: 'Content B Name', stores: [])
    end

    it 'returns all Stores for resource' do
      get '/api/v1/contents', params: { includes: 'stores' }, headers: default_headers

      expect(json_response[:data][0][:stores].size).to eq(3)
    end

    it 'returns no Stores for resource' do
      get '/api/v1/contents', params: { includes: 'stores' }, headers: default_headers

      expect(json_response[:data][1][:stores].size).to eq(0)
    end
  end

  describe 'with pagination' do
    before do
      ('A'..'Z').each { |letter| create(:content, site: site, name: "Content #{letter} Name") }
    end

    it 'returns the second page of results' do
      get '/api/v1/contents', params: { page: 2, per_page: 2 }, headers: default_headers

      expect(json_response[:data].pluck(:name)).to eq(['Content C Name', 'Content D Name'])
    end

    it 'finds nothing outside the count' do
      get '/api/v1/contents', params: { page: 2, per_page: 26 }, headers: default_headers

      expect(json_response[:data].pluck(:name)).to eq([])
    end
  end

  describe 'when no resources are found' do
    before do
      get '/api/v1/contents', headers: default_headers
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
      get '/api/v1/contents', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
