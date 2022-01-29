# frozen_string_literal: true

RSpec.describe 'Manage Auth - Login', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user, email: 'me@email.com', password: 'my secure password') }

  before { create(:user_site, user: profile, site: site) }

  describe 'accessing section when not logged in' do
    it 'redirects to login page' do
      visit '/manage/contents'

      expect(page).to have_current_path('/manage/login')
    end
  end

  describe 'with valid credentials' do
    it 'redirects to Dashboard' do
      visit '/manage/login'

      fill_in_and_submit_login_form_with(email: 'me@email.com', password: 'my secure password')

      expect(page).to have_current_path('/manage')
    end

    it 'redirects to requested resource' do
      visit '/manage/contents'

      fill_in_and_submit_login_form_with(email: 'me@email.com', password: 'my secure password')

      expect(page).to have_current_path('/manage/contents')
    end
  end

  describe 'with invalid or unknown user credentials' do
    it 'is not successful' do
      visit '/manage/login'

      fill_in_and_submit_login_form_with(email: 'unknown@email.com', password: 'my secure password')

      expect(page.body).to have_content 'Invalid Email or password'
    end
  end

  describe 'with invited but not accepted User' do
    let(:message) { 'You have a pending invitation, accept it to finish creating your account' }
    let(:profile) { create(:user, :invited, email: 'me@email.com', password: 'my secure password') }

    before { visit '/manage/login' }

    it 'fails with error message' do
      fill_in_and_submit_login_form_with(email: 'me@email.com', password: 'my secure password')

      expect(page).to have_content(message)
    end
  end

  describe 'with multiple failed login attempts' do
    let(:message) { 'You have one more attempt before your account is locked.' }

    before { visit '/manage/login' }

    it 'sends a warning before locking account after 4 failed login attempts' do
      4.times do
        fill_in_and_submit_login_form_with(email: 'me@email.com', password: 'wrong password')
      end

      expect(page).to have_content(message)
    end

    it 'locks account after 5 failed login attempts' do
      5.times do
        fill_in_and_submit_login_form_with(email: 'me@email.com', password: 'wrong password')
      end

      expect(page).to have_content('Your account is locked.')
    end
  end

  describe 'with locked User' do
    let(:profile) { create(:user, locked_at: 59.minutes.ago, email: 'me@email.com', password: 'my secure password') }

    before { visit '/manage/login' }

    it 'fails with error message before lock timeout expires' do
      fill_in_and_submit_login_form_with(email: 'me@email.com', password: 'my secure password')

      expect(page).to have_content('Your account is locked.')
    end

    it 'is successful with recently unlocked user after lock timeout expired' do
      travel_to(2.minutes.from_now)

      fill_in_and_submit_login_form_with(email: 'me@email.com', password: 'my secure password')

      expect(page).to have_content('Signed in successfully.')
    end
  end
end
