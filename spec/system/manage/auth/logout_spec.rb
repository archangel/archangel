# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Auth - Logout', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  it 'redirects to login page after logout' do
    visit '/manage'

    within(:css, 'header.navbar .nav') { click_link('Sign Out') }

    expect(page).to have_current_path('/manage/login')
  end
end
