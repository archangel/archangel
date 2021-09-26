# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API v1 Group delete', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:access_token) { profile.auth_token }
  let(:resource) { create(:content, site: site) }

  before do
    create(:user_site, user: profile, site: site)

    delete "/api/v1/contents/#{resource.slug}",
           headers: { accept: 'application/json', authorization: access_token }
  end

  it 'returns correct status (204)' do
    expect(response).to have_http_status(:no_content)
  end

  it 'does not return a body' do
    expect(response.body).to be_empty
  end

  it 'does not destroy resource (soft delete)' do
    expect(resource.reload.discarded_at).not_to be_nil
  end
end
