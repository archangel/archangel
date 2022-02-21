# frozen_string_literal: true

RSpec.describe 'Manage User #retoken', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    sign_in(profile)
  end

  it 'returns success message' do
    visit "/manage/users/#{resource.id}"

    click_on 'Regenerate'

    expect(page).to have_content('User authentication token has been successfully regenerated.')
  end

  it 'generates a new token' do
    visit "/manage/users/#{resource.id}"

    expect do
      click_on 'Regenerate'
      resource.reload
    end.to change(resource, :auth_token)
  end
end
