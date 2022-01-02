# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage User #unlock', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:user, :locked) }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    sign_in(profile)
  end

  it 'returns success message' do
    visit "/manage/users/#{resource.id}"

    within(:css, '.btn-toolbar') { click_on 'Unlock User' }

    expect(page).to have_content('User was successfully unlocked.')
  end
end
