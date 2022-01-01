# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Collection #new', type: :system, js: true do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource_data) do
    {
      name: 'Wonderful Collection',
      slug: 'wonderful',
      published_at: 1.minute.ago
    }
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit '/manage/collections/new'
  end

  describe 'when successful' do
    before do
      fill_in_collection_form_with(resource_data)
      fill_in_collection_field_form_with(label: 'Foo Bar', key: 'fooBar')
    end

    it 'returns success message' do
      submit_create_collection_form

      expect(page).to have_content('Collection was successfully created.')
    end

    describe 'with fields' do
      it 'successful with single field' do
        fill_in_collection_field_form_with(label: 'Bat Baz', key: 'batBaz')

        submit_create_collection_form

        expect(page).to have_content('Collection was successfully created.')
      end

      it 'successful with multiple fields' do
        add_and_fill_in_collection_field_form_with(label: 'Bat Baz', key: 'batBaz')

        submit_create_collection_form

        expect(page).to have_content('Collection was successfully created.')
      end
    end
  end

  describe 'when not successful' do
    it 'fails without `name`' do
      updated_resource_data = resource_data.merge(name: '')

      fill_in_and_create_collection_form_with(updated_resource_data)

      expect(page.find('.string.collection_name')).to have_content("can't be blank")
    end

    it 'fails with existing `slug`' do
      create(:collection, site: site, slug: 'wonderful')
      updated_resource_data = resource_data.merge(slug: 'wonderful')

      fill_in_and_create_collection_form_with(updated_resource_data)

      expect(page.find('.slug.collection_slug')).to have_content('has already been taken')
    end

    describe 'with fields' do
      before do
        fill_in_collection_form_with(resource_data)
      end

      it 'fails without field `label` value' do
        fill_in_collection_field_form_with(label: '', key: 'foo')

        submit_create_collection_form

        within(:css, '#collection_collection_fields .nested-fields:nth-child(1)') do
          expect(page.find('.string.collection_collection_fields_label')).to have_content("can't be blank")
        end
      end

      it 'fails without field `key` value is not camel case' do
        fill_in_collection_field_form_with(label: 'Foo Bar', key: 'foo_bar')

        submit_create_collection_form

        within(:css, '#collection_collection_fields .nested-fields:nth-child(1)') do
          expect(page.find('.camel_case.collection_collection_fields_key'))
            .to have_content('must be camel case (eg. camelCase)')
        end
      end
    end
  end
end
