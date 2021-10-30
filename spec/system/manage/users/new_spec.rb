# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage User #new', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource_data) do
    {
      first_name: 'John',
      last_name: 'Doe',
      username: 'johndoe',
      email: 'john@doe.com',
      role: 'Administrator'
    }
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit '/manage/users/new'
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_and_create_user_form_with(resource_data)

      expect(page).to have_content('User was successfully created.')
    end

    it 'is successful without `last_name`' do
      updated_resource_data = resource_data.merge(last_name: '')

      fill_in_and_create_user_form_with(updated_resource_data)

      expect(page).to have_content('User was successfully created.')
    end
  end

  describe 'when not successful' do
    it 'fails without `first_name`' do
      updated_resource_data = resource_data.merge(first_name: '')

      fill_in_and_create_user_form_with(updated_resource_data)

      expect(page.find('.string.user_first_name')).to have_content("can't be blank")
    end

    it 'fails without `username`' do
      updated_resource_data = resource_data.merge(username: '')

      fill_in_and_create_user_form_with(updated_resource_data)

      expect(page.find('.string.user_username')).to have_content("can't be blank")
    end

    it 'fails without `email`' do
      updated_resource_data = resource_data.merge(email: '')

      fill_in_and_create_user_form_with(updated_resource_data)

      expect(page.find('.email.user_email')).to have_content("can't be blank")
    end
  end
end
