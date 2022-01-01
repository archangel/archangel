# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Collection #edit', type: :system, js: true do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource_fields) { build_list(:collection_field, 1) }
  let(:resource) { create(:collection, site: site, collection_fields: resource_fields, name: 'My Collection') }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit "/manage/collections/#{resource.id}/edit"
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_and_update_collection_form_with(name: 'Updated Collection Name')

      expect(page).to have_content('Collection was successfully updated.')
    end

    describe 'with fields' do
      it 'does not allow editing field `key`' do
        within(:css, '#collection_collection_fields .nested-fields:nth-child(1)') do
          expect(page).to have_css("input[name$='[key]'][disabled]")
        end
      end

      it 'successful when updating a field' do
        fill_in_collection_field_form_with(label: 'Hello')

        submit_update_collection_form

        expect(page).to have_content('Collection was successfully updated.')
      end

      xit 'successful when adding a field' do
        add_and_fill_in_collection_field_form_with(label: 'Bar', key: 'bar')

        submit_update_collection_form

        expect(page).to have_content('Collection was successfully updated.')
      end

      xit 'successful when removing a field and adding a new field' do
        within(:css, '#collection_collection_fields .nested-fields:nth-child(1)') do
          click_link 'Remove Collection Field'
        end

        add_and_fill_in_collection_field_form_with(label: 'Foo', key: 'foo')

        submit_update_collection_form

        expect(page).to have_content('Collection was successfully updated.')
      end
    end
  end

  describe 'when not successful' do
    xit 'fails with existing `slug`' do
      create(:collection, site: site, slug: 'wonderful')

      fill_in_and_update_collection_form_with(slug: 'wonderful')

      expect(page.find('.slug.collection_slug')).to have_content('has already been taken')
    end

    describe 'with fields' do
      xit 'fails without field `label` value' do
        fill_in_collection_field_form_with(label: '')

        submit_update_collection_form

        within(:css, '#collection_collection_fields .nested-fields:nth-child(1)') do
          expect(page.find('.string.collection_collection_fields_label')).to have_content("can't be blank")
        end
      end

      xit 'fails when field `key` value is not camel case' do
        add_and_fill_in_collection_field_form_with(label: 'Foo Bar', key: 'foo_bar')

        submit_update_collection_form

        within(:css, '#collection_collection_fields .nested-fields:nth-child(1)') do
          expect(page.find('.camel_case.collection_collection_fields_key'))
            .to have_content('must be camel case (eg. camelCase)')
        end
      end
    end
  end
end
