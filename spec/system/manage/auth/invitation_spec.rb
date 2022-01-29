# frozen_string_literal: true

RSpec.describe 'Manage Auth - Accept Invitation', type: :system do
  let(:site) { create(:site) }
  let(:resource_data) do
    {
      first_name: 'John',
      last_name: 'Doe',
      username: 'johndoe',
      password: 'wonderfulpassword'
    }
  end

  describe 'with valid invitiation' do
    let(:invitation_token) { Devise.token_generator.generate(User, :invitation_token) }
    let(:invitee) { create(:user, :invited, invitation_token: invitation_token.last) }

    before do
      create(:user_site, user: invitee, site: site)

      visit "/manage/invitation/accept?invitation_token=#{invitation_token.first}"
    end

    describe 'when successful' do
      it 'redirects to Manage Dashboard' do
        fill_in_and_submit_invitation_form_with(resource_data)

        expect(page).to have_current_path('/manage')
      end

      it 'returns password set success message' do
        fill_in_and_submit_invitation_form_with(resource_data)

        expect(page).to have_content('Your password was set successfully')
      end

      it 'returns signed in success message' do
        fill_in_and_submit_invitation_form_with(resource_data)

        expect(page).to have_content('You are now signed in')
      end
    end

    describe 'when not successful' do
      it 'fails without `first_name`' do
        fill_in_and_submit_invitation_form_with(first_name: '')

        expect(page.find('.password.user_password')).to have_content("can't be blank")
      end

      it 'fails with used `username`' do
        create(:user, username: 'johndoe')
        fill_in_and_submit_invitation_form_with(username: 'johndoe')

        expect(page.find('.string.user_username')).to have_content('has already been taken')
      end

      it 'fails with short `password`' do
        fill_in_and_submit_invitation_form_with(password: 'short')

        expect(page.find('.password.user_password')).to have_content('is too short (minimum is 6 characters)')
      end

      it 'fails with mismatches `password` and `password_confirmation`' do
        fill_in_and_submit_invitation_form_with(password: 'wonderful-password', password_confirmation: 'good-password')

        expect(page.find('.password.user_password_confirmation')).to have_content("doesn't match Password")
      end
    end
  end

  describe 'with invalid invitation' do
    it 'redirects to Home' do
      visit '/manage/invitation/accept?invitation_token=invalid-token'

      expect(page).to have_current_path('/')
    end
  end
end
