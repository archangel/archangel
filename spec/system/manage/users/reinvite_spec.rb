# frozen_string_literal: true

RSpec.describe 'Manage User #reinvite', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:user, :invited) }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    sign_in(profile)
  end

  it 'returns success message' do
    visit "/manage/users/#{resource.id}"

    within(:css, '.btn-toolbar') { click_on 'Reinvite User' }

    expect(page).to have_content('User was successfully reinvited.')
  end
end
