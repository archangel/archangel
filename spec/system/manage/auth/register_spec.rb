# frozen_string_literal: true

RSpec.describe 'Manage Auth - Register', type: :system, skip: true do
  let(:site) { create(:site) }
  let(:resource_data) do
    {
      email: 'wonderful@example.com',
      first_name: 'Wonderful',
      last_name: 'User',
      username: 'wonderful_user',
      password: 'wonderfulpassword'
    }
  end

  it 'has an input field for First Name on registration form' do
    visit '/manage/register'

    expect(page).to have_css("input[name='user[first_name]']")
  end

  it 'has an input field for Last Name on registration form' do
    visit '/manage/register'

    expect(page).to have_css("input[name='user[last_name]']")
  end

  it 'has an input field for Username on registration form' do
    visit '/manage/register'

    expect(page).to have_css("input[name='user[username]']")
  end

  describe 'when successful' do
    before { visit '/manage/register' }

    it 'returns success message' do
      fill_in_and_submit_register_form_with(resource_data)

      expect(page).to have_content('You have signed up successfully')
    end

    it 'redirects to Manage Dashboard' do
      fill_in_and_submit_register_form_with(resource_data)

      expect(page).to have_current_path('/manage')
    end

    xit 'creates User with `admin` role' do
      fill_in_and_submit_register_form_with(resource_data)

      created_user = User.last

      expect(created_user.role).to eq('admin')
    end
  end

  describe 'when not successful' do
    before { visit '/manage/register' }

    it 'fails without `email`' do
      fill_in_and_submit_register_form_with({})

      expect(page.find('.email.user_email')).to have_content("can't be blank")
    end

    it 'fails without `first_name`' do
      fill_in_and_submit_register_form_with({})

      expect(page.find('.string.user_first_name')).to have_content("can't be blank")
    end

    it 'fails without `username`' do
      fill_in_and_submit_register_form_with({})

      expect(page.find('.string.user_username')).to have_content("can't be blank")
    end

    it 'fails with repeated `username`' do
      create(:user, username: 'wonderful')

      fill_in_and_submit_register_form_with(username: 'wonderful')

      expect(page.find('.string.user_username')).to have_content('has already been taken')
    end

    it 'fails with invalid `username`' do
      fill_in_and_submit_register_form_with(username: 'Username')

      expect(page.find('.string.user_username')).to have_content('is not a valid slug')
    end

    it 'fails with short `password`' do
      fill_in_and_submit_register_form_with(password: 'short')

      expect(page.find('.password.user_password')).to have_content('is too short (minimum is 6 characters)')
    end

    it 'fails with mismatches `password` and `password_confirmation`' do
      fill_in_and_submit_register_form_with(password: 'wonderful-password', password_confirmation: 'good-password')

      expect(page.find('.password.user_password_confirmation')).to have_content("doesn't match Password")
    end
  end
end
