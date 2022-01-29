# frozen_string_literal: true

RSpec.describe 'Manage Site #edit', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource_data) do
    {
      name: 'Wonderful Site',
      format_datetime: '%B %-d, %Y @ %I:%M:%S %p'
    }
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit '/manage/site/edit'
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_and_update_site_form_with(resource_data)

      expect(page).to have_content('Site was successfully updated.')
    end

    describe 'with stores' do
      it 'successful with single store' do
        fill_in_site_form_with(resource_data)
        add_and_fill_in_site_store_form_with(key: 'foo', value: 'bar')

        submit_update_site_form

        expect(page).to have_content('Site was successfully updated.')
      end

      it 'successful with multiple stores' do
        fill_in_site_form_with(resource_data)
        add_and_fill_in_site_store_form_with(key: 'foo', value: 'bar')
        add_and_fill_in_site_store_form_with(key: 'bat', value: 'baz')

        submit_update_site_form

        expect(page).to have_content('Site was successfully updated.')
      end

      it 'successful without store `value` value' do
        fill_in_site_form_with(resource_data)
        add_and_fill_in_site_store_form_with(key: 'foo', value: '')

        submit_update_site_form

        expect(page).to have_content('Site was successfully updated.')
      end
    end
  end

  describe 'when not successful' do
    it 'fails with existing `subdomain`' do
      create(:site, subdomain: 'wonderful')
      updated_resource_data = resource_data.merge(subdomain: 'wonderful')

      fill_in_and_update_site_form_with(updated_resource_data)

      expect(page.find('.subdomain.site_subdomain')).to have_content('has already been taken')
    end

    describe 'with stores', js: true do
      before do
        fill_in_site_form_with(resource_data)
      end

      it 'fails without store `key` value' do
        add_and_fill_in_site_store_form_with(key: '', value: 'foo')

        submit_update_site_form

        within(:css, '#site_stores .nested-fields:nth-child(1)') do
          expect(page.find('.camel_case.site_stores_key')).to have_content("can't be blank")
        end
      end
    end
  end

  describe 'with `reader` role' do
    before do
      profile.user_site.update(role: 'reader')

      visit '/manage/site/edit'
    end

    it 'returns an unauthorized status code' do
      expect(page).to have_content('Unauthorized')
    end

    it 'returns an unauthorized error message' do
      expect(page).to have_content('Error 401')
    end
  end
end
