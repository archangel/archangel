# frozen_string_literal: true

RSpec.describe 'API v1 User update', type: :request do
  let(:site) { create(:site) }
  let(:profile) { create(:user, email: 'me@example.com') }
  let(:access_token) { profile.auth_token }
  let(:resource) { create(:user, :locked, email: 'locked@example.com') }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    post "/api/v1/users/#{resource.username}/unlock",
         headers: { accept: 'application/json', authorization: access_token }
  end

  it 'returns correct status (202)' do
    expect(response).to have_http_status(:accepted)
  end

  it 'returns correct resource' do
    expect(json_response[:data][:email]).to eq('locked@example.com')
  end
end
