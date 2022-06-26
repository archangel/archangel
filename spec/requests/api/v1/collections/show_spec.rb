# frozen_string_literal: true

RSpec.describe 'API v1 Collection detail', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:default_headers) { { accept: 'application/json', authorization: profile.auth_token } }
  let(:resource) { create(:collection, site: site, name: 'My Collection') }

  before do
    create(:user_site, user: profile, site: site)
  end

  describe 'when resource is found' do
    before do
      get "/api/v1/collections/#{resource.slug}", headers: default_headers
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns correct resource' do
      expect(json_response[:data][:name]).to eq('My Collection')
    end

    it 'matches schema' do
      expect(response).to match_json_schema('api/v1/collections/show')
    end
  end

  describe 'with includes' do
    describe 'with collection_fields include' do
      before do
        resource.update(collection_fields: build_list(:collection_field, 3))
      end

      it 'returns all CollectionFields for resource' do
        get "/api/v1/collections/#{resource.slug}", params: { includes: 'collection_fields' }, headers: default_headers

        expect(json_response[:data][:fields].size).to eq(3)
      end

      it 'does not return CollectionFields key without includes' do
        get "/api/v1/collections/#{resource.slug}", headers: default_headers

        expect(json_response[:data].keys).not_to include(:fields)
      end
    end

    describe 'with collection_fields include' do
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
        resource.update(collection_fields: collection_fields, collection_entries: collection_entries)
      end

      it 'returns all CollectionEntries for resource' do
        get "/api/v1/collections/#{resource.slug}", params: { includes: 'collection_fields,collection_entries' }, headers: default_headers

        expect(json_response[:data][:entries].size).to eq(1)
      end

      it 'does not return CollectionEntries key without includes' do
        get "/api/v1/collections/#{resource.slug}", headers: default_headers

        expect(json_response[:data].keys).not_to include(:entries)
      end
    end



    #   before do
    #     create(:collection, site: site, name: 'Collection A Name',
    #                         collection_fields: collection_fields, collection_entries: collection_entries)
    #     create(:collection, site: site, name: 'Collection B Name',
    #                         collection_fields: collection_fields, collection_entries: [])
    #   end

    #   it 'returns all CollectionFields for resource' do
    #     get '/api/v1/collections', params: { includes: 'collection_fields,collection_entries' }, headers: default_headers

    #     expect(json_response[:data][0][:entries].size).to eq(1)
    #   end

    #   it 'returns no CollectionFields for resource' do
    #     get '/api/v1/collections', params: { includes: 'collection_fields,collection_entries' }, headers: default_headers

    #     expect(json_response[:data][1][:entries].size).to eq(0)
    #   end
    # end



  end

  describe 'when resource is not found' do
    before do
      get '/api/v1/collections/0000', headers: default_headers
    end

    it 'returns 404 status' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error message' do
      expect(json_response[:message]).to eq('Collection not found')
    end
  end

  describe 'when no authorization token is sent' do
    before do
      get '/api/v1/collections/1234', headers: default_headers.except(:authorization)
    end

    it 'returns 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
