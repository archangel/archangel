# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API v1 User delete', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user, email: 'me@example.com') }
  let(:access_token) { profile.auth_token }
  let(:resource) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    delete "/api/v1/users/#{resource.username}",
           headers: { accept: 'application/json', authorization: access_token }
  end

  it 'returns correct status (204)' do
    expect(response).to have_http_status(:no_content)
  end

  it 'does not return a body' do
    expect(response.body).to be_empty
  end

  it 'really deletes the resource (not a soft delete)' do
    expect { resource.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
