# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Content #new', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource_data) do
    {
      name: 'Wonderful Content',
      slug: 'wonderful',
      body: '<p>Wonderful content.</p>',
      published_at: 1.minute.ago
    }
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit '/manage/contents/new'
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_and_create_content_form_with(resource_data)

      expect(page).to have_content('Content was successfully created.')
    end

    it 'is successful without `body`' do
      updated_resource_data = resource_data.merge(body: '')

      fill_in_and_create_content_form_with(updated_resource_data)

      expect(page).to have_content('Content was successfully created.')
    end

    describe 'with stores' do
      it 'successful with single store' do
        fill_in_content_form_with(resource_data)
        add_and_fill_in_content_store_form_with(key: 'foo', value: 'bar')

        submit_create_content_form

        expect(page).to have_content('Content was successfully created.')
      end

      it 'successful with multiple stores' do
        fill_in_content_form_with(resource_data)
        add_and_fill_in_content_store_form_with(key: 'foo', value: 'bar')
        add_and_fill_in_content_store_form_with(key: 'bat', value: 'baz')

        submit_create_content_form

        expect(page).to have_content('Content was successfully created.')
      end

      it 'successful without store `value` value' do
        fill_in_content_form_with(resource_data)
        add_and_fill_in_content_store_form_with(key: 'foo', value: '')

        submit_create_content_form

        expect(page).to have_content('Content was successfully created.')
      end
    end
  end

  describe 'when not successful' do
    it 'fails without `name`' do
      updated_resource_data = resource_data.merge(name: '')

      fill_in_and_create_content_form_with(updated_resource_data)

      expect(page.find('.string.content_name')).to have_content("can't be blank")
    end

    it 'fails with existing `slug`' do
      create(:content, site: site, slug: 'wonderful')
      updated_resource_data = resource_data.merge(slug: 'wonderful')

      fill_in_and_create_content_form_with(updated_resource_data)

      expect(page.find('.slug.content_slug')).to have_content('has already been taken')
    end

    describe 'with stores', js: true do
      before do
        fill_in_content_form_with(resource_data)
      end

      it 'fails without store `key` value' do
        add_and_fill_in_content_store_form_with(key: '', value: 'foo')

        submit_create_content_form

        within(:css, '#content_stores .nested-fields:nth-child(1)') do
          expect(page.find('.camel_case.content_stores_key')).to have_content("can't be blank")
        end
      end
    end
  end
end
