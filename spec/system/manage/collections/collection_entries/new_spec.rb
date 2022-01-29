# frozen_string_literal: true

RSpec.describe 'Manage Collection Entry #new', type: :system, js: true do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:parent_resource_fields) do
    [
      build(:field, :string, label: 'Field String', key: 'string', required: true),
      build(:field, :text, label: 'Field Text', key: 'text', required: true),
      build(:field, :email, label: 'Field Email', key: 'email', required: true),
      build(:field, :url, label: 'Field Url', key: 'url', required: true),
      build(:field, :integer, label: 'Field Integer', key: 'integer', required: true),
      build(:field, :boolean, label: 'Field Boolean', key: 'boolean', required: true),
      build(:field, :datetime, label: 'Field Datetime', key: 'datetime', required: true),
      build(:field, :date, label: 'Field Date', key: 'date', required: true),
      build(:field, :time, label: 'Field Time', key: 'time', required: true)
    ]
  end
  let(:parent_resource) { create(:collection, site: site, collection_fields: parent_resource_fields) }

  let(:resource_data) do
    {
      string: 'My String',
      text: 'My long text',
      email: 'me@example.com',
      url: 'https://example.com',
      integer: 1234,
      boolean: true,
      datetime: '2020-05-25 15:30:00',
      date: '1979-11-24',
      time: '03:41',
      published_at: 1.minute.ago
    }
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit "/manage/collections/#{parent_resource.id}/collection_entries/new"

    fill_in 'Field String (string)', with: 'My String'
    fill_in 'Field Text (text)', with: 'My long text'
    fill_in 'Field Email (email)', with: 'me@example.com'
    fill_in 'Field Url (url)', with: 'https://example.com'
    fill_in 'Field Integer (integer)', with: 1234
    form_checbox_check('Field Boolean (boolean)', true)
    select_flatpickr_date('2020-05-25 15:30:00', from: 'Field Datetime (datetime)')
    select_flatpickr_date('1979-11-24', from: 'Field Date (date)')
    select_flatpickr_date(1.minute.ago, from: 'Field Time (time)')
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_collection_entry_form_with(published_at: 1.minute.ago)

      submit_create_collection_entry_form

      expect(page).to have_content('Collection Entry was successfully created.')
    end

    it 'is valid without a Publish Date' do
      submit_create_collection_entry_form

      expect(page).to have_content('Collection Entry was successfully created.')
    end
  end

  describe 'when not successful' do
    it 'fails without required field' do
      fill_in 'Field String (string)', with: ''

      submit_create_collection_entry_form

      expect(page.find('.string.collection_entry_string')).to have_content("can't be blank")
    end

    it 'fails when email field is not an email' do
      fill_in 'Field Email (email)', with: 'not an email'

      submit_create_collection_entry_form

      expect(page.find('.email.collection_entry_email')).to have_content('is not a valid email')
    end

    it 'fails when url field is not a url' do
      fill_in 'Field Url (url)', with: 'example.com'

      submit_create_collection_entry_form

      expect(page.find('.url.collection_entry_url')).to have_content('is not a valid URL')
    end
  end
end
