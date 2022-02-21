# frozen_string_literal: true

RSpec.describe 'Manage User #edit', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:user) }
  let(:resource_data) do
    {
      first_name: 'John',
      last_name: 'Doe'
    }
  end

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    sign_in(profile)

    visit "/manage/users/#{resource.id}/edit"
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_and_update_user_form_with(resource_data)

      expect(page).to have_content('User was successfully updated.')
    end
  end

  describe 'when not successful' do
    it 'fails without `first_name`' do
      fill_in 'First Name', with: ''

      submit_update_user_form

      expect(page.find('.string.user_first_name')).to have_content("can't be blank")
    end

    it 'fails without `username`' do
      fill_in 'Username', with: ''

      submit_update_user_form

      expect(page.find('.string.user_username')).to have_content("can't be blank")
    end

    it 'fails with used `username`' do
      fill_in 'Username', with: profile.username

      submit_update_user_form

      expect(page.find('.string.user_username')).to have_content('has already been taken')
    end
  end
end
