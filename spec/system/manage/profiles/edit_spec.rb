# frozen_string_literal: true

RSpec.describe 'Manage Profile #edit', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource_data) do
    {
      first_name: 'John',
      last_name: 'Doe'
      # username: 'wonderful',
      # email: 'wonderful',
      # password: 'wonderful',
      # password_confirmation: 'wonderful',
    }
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit '/manage/profile/edit'
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_and_update_profile_form_with(resource_data)

      expect(page).to have_content('Profile was successfully updated.')
    end

    describe 'with password' do
      it 'updates with matching `password` and `password_confirmation` values' do
        fill_in_and_update_profile_form_with(password: 'new password', confirm_password: 'new password')

        expect(page).to have_content('Profile was successfully updated.')
      end

      it 'updates without `password` but with `password_confirmation` (password not changed)' do
        fill_in_and_update_profile_form_with(password: '', confirm_password: 'new password')

        expect(page).to have_content('Profile was successfully updated.')
      end
    end
  end

  describe 'when not successful' do
    it 'fails with existing `username`' do
      create(:user, username: 'wonderful')
      updated_resource_data = resource_data.merge(username: 'wonderful')

      fill_in_and_update_profile_form_with(updated_resource_data)

      expect(page.find('.username.profile_username')).to have_content('has already been taken')
    end

    it 'fails with existing `email`' do
      create(:user, email: 'wonderful@example.com')
      updated_resource_data = resource_data.merge(email: 'wonderful@example.com')

      fill_in_and_update_profile_form_with(updated_resource_data)

      expect(page.find('.email.profile_email')).to have_content('has already been taken')
    end

    describe 'with password' do
      it 'fails with short `password`' do
        fill_in_and_update_profile_form_with(password: 'abcde', password_confirmation: 'abcde')

        expect(page.find('.password.profile_password')).to have_content('is too short (minimum is 6 characters)')
      end

      it 'fails with `password` but without `password_confirmation`' do
        fill_in_and_update_profile_form_with(password: 'new password', password_confirmation: '')

        expect(page.find('.password.profile_password_confirmation')).to have_content("doesn't match Password")
      end
    end
  end
end
