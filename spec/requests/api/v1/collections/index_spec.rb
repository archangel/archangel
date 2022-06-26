# frozen_string_literal: true

RSpec.describe 'API v1 Collection listing', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'with default options' do
    before do
      ('A'..'Z').each { |letter| create(:collection, site: site, name: "Collection #{letter} Name") }

      get '/api/v1/collections', headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns items in default order (name asc)' do
      expected_response = ('A'..'X').map { |letter| "Collection #{letter} Name" }

      expect(json_response[:data].pluck(:name)).to eq(expected_response)
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/collections/index')
    end
  end

  describe 'with sorting' do
    before do
      ('A'..'C').each do |letter|
        create(:collection, site: site, name: "Collection #{letter} Name", slug: "slug_#{letter.downcase}")
      end
    end

    describe 'with name sorting' do
      it 'sorts by name asc' do
        get '/api/v1/collections', params: { sort: 'name' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Collection A Name', 'Collection B Name', 'Collection C Name'])
      end

      it 'sorts by name desc' do
        get '/api/v1/collections', params: { sort: '-name' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Collection C Name', 'Collection B Name', 'Collection A Name'])
      end
    end

    describe 'with slug sorting' do
      it 'sorts by slug asc' do
        get '/api/v1/collections', params: { sort: 'slug' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Collection A Name', 'Collection B Name', 'Collection C Name'])
      end

      it 'sorts by slug desc' do
        get '/api/v1/collections', params: { sort: '-slug' }, headers: default_headers

        expect(json_response[:data].pluck(:name)).to eq(['Collection C Name', 'Collection B Name', 'Collection A Name'])
      end
    end
  end

  describe 'with includes' do
    describe 'with collection_fields include' do
      before do
        create(:collection, site: site, name: 'Collection A Name', collection_fields: build_list(:collection_field, 3))
        create(:collection, site: site, name: 'Collection B Name', collection_fields: [])
      end

      it 'returns all CollectionFields for resource' do
        get '/api/v1/collections', params: { includes: 'collection_fields' }, headers: default_headers

        expect(json_response[:data][0][:fields].size).to eq(3)
      end

      it 'returns no CollectionFields for resource' do
        get '/api/v1/collections', params: { includes: 'collection_fields' }, headers: default_headers

        expect(json_response[:data][1][:fields].size).to eq(0)
      end
    end

    describe 'with collection_entries include' do
      let(:collection_fields) do
        [
          build(:collection_field, :string, :required, key: 'stringField', label: 'String Field'),
          build(:collection_field, :integer, :required, key: 'integerField', label: 'Integer Field'),
          build(:collection_field, :boolean, :required, key: 'booleanField', label: 'Boolean Field'),
          build(:collection_field, :datetime, :required, key: 'datetimeField', label: 'Datetime Field'),
          build(:collection_field, :date, :required, key: 'dateField', label: 'Date Field'),
          build(:collection_field, :time, :required, key: 'timeField', label: 'Time Field')
        ]
      end
      let(:collection_entries) do
        [
          build(:collection_entry, content: { stringField: 'Collection Entry String',
                                              integerField: '123',
                                              booleanField: true,
                                              datetimeField: '2020-05-25 03:41:18',
                                              dateField: '2020-05-25',
                                              timeField: '03:41:18' })
        ]
      end

      before do
        create(:collection, site: site, name: 'Collection A Name',
                            collection_fields: collection_fields, collection_entries: collection_entries)
        create(:collection, site: site, name: 'Collection B Name',
                            collection_fields: collection_fields, collection_entries: [])
      end

      it 'returns all CollectionEntries for resource' do
        get '/api/v1/collections', params: { includes: 'collection_fields,collection_entries' }, headers: default_headers

        expect(json_response[:data][0][:entries].size).to eq(1)
      end

      it 'returns no CollectionEntries for resource' do
        get '/api/v1/collections', params: { includes: 'collection_fields,collection_entries' }, headers: default_headers

        expect(json_response[:data][1][:entries].size).to eq(0)
      end
    end
  end

  describe 'with pagination' do
    before do
      ('A'..'Z').each { |letter| create(:collection, site: site, name: "Collection #{letter} Name") }
    end

    it 'returns the second page of results' do
      get '/api/v1/collections', params: { page: 2, per_page: 2 }, headers: default_headers

      expect(json_response[:data].pluck(:name)).to eq(['Collection C Name', 'Collection D Name'])
    end

    it 'finds nothing outside the count' do
      get '/api/v1/collections', params: { page: 2, per_page: 26 }, headers: default_headers

      expect(json_response[:data].pluck(:name)).to eq([])
    end
  end

  describe 'when no resources are found' do
    before do
      get '/api/v1/collections', headers: default_headers
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
      get '/api/v1/collections', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
