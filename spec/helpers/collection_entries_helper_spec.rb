# frozen_string_literal: true

RSpec.describe CollectionEntriesHelper, type: :helper do
  let(:site) { create(:site) }

  helper do
    def current_site; end
  end

  before { allow(helper).to receive(:current_site).and_return(site) }

  context 'with #collection_entry_status(resource)' do
    let(:discarded_collectioncollection_entry) { build(:collection_entry, :discarded) }
    let(:draft_collectioncollection_entry) { build(:collection_entry, :unpublished) }
    let(:scheduled_collectioncollection_entry) { build(:collection_entry, :scheduled) }
    let(:available_collectioncollection_entry) { build(:collection_entry) }

    it 'returns `deleted` class' do
      expect(helper.collection_status(discarded_collectioncollection_entry)).to eq('deleted')
    end

    it 'returns `draft` class' do
      expect(helper.collection_status(draft_collectioncollection_entry)).to eq('draft')
    end

    it 'returns `scheduled` class' do
      expect(helper.collection_status(scheduled_collectioncollection_entry)).to eq('scheduled')
    end

    it 'returns `available` class' do
      expect(helper.collection_status(available_collectioncollection_entry)).to eq('available')
    end
  end

  context 'with #collection_entry_value(entry, classification, key)' do
    it 'returns value for string' do
      entry = build(:collection_entry, content: { foo: 'hello' })

      expect(helper.collection_entry_value(entry, 'string', 'foo')).to eq('hello')
    end

    it 'returns value for text' do
      entry = build(:collection_entry, content: { foo: 'hello' })

      expect(helper.collection_entry_value(entry, 'text', 'foo')).to eq('hello')
    end

    it 'returns value for email' do
      entry = build(:collection_entry, content: { foo: 'hello@world.com' })

      expect(helper.collection_entry_value(entry, 'email', 'foo')).to eq('hello@world.com')
    end

    it 'returns value for url' do
      entry = build(:collection_entry, content: { foo: 'https://example.com' })

      expect(helper.collection_entry_value(entry, 'url', 'foo')).to eq('https://example.com')
    end

    it 'returns value for integer' do
      entry = build(:collection_entry, content: { foo: '1234' })

      expect(helper.collection_entry_value(entry, 'integer', 'foo')).to eq(1234)
    end

    it 'returns value for datetime' do
      entry = build(:collection_entry, content: { foo: 'May 25th, 2020 15:41:18' })

      expect(helper.collection_entry_value(entry, 'datetime', 'foo')).to eq('May 25, 2020 @ 03:41 PM')
    end

    it 'returns value for date' do
      entry = build(:collection_entry, content: { foo: 'Monday May 25th, 2020' })

      expect(helper.collection_entry_value(entry, 'date', 'foo')).to eq('May 25, 2020')
    end

    it 'returns value for time' do
      entry = build(:collection_entry, content: { foo: '15:41:18' })

      expect(helper.collection_entry_value(entry, 'time', 'foo')).to eq('03:41 PM')
    end
  end

  context 'with #collection_entry_string(value)' do
    it 'returns string for string' do
      expect(helper.collection_entry_string('hello')).to eq('hello')
    end

    it 'returns string for blank string' do
      expect(helper.collection_entry_string('')).to eq('')
    end

    it 'returns string for nil' do
      expect(helper.collection_entry_string(nil)).to eq('')
    end
  end

  context 'with #collection_entry_text(value)' do
    it 'returns string for string' do
      expect(helper.collection_entry_text('hello')).to eq('hello')
    end

    it 'returns string for blank string' do
      expect(helper.collection_entry_text('')).to eq('')
    end

    it 'returns string for nil' do
      expect(helper.collection_entry_text(nil)).to eq('')
    end
  end

  context 'with #collection_entry_email(value)' do
    it 'returns string for email string' do
      expect(helper.collection_entry_email('hello@world.com')).to eq('hello@world.com')
    end

    it 'returns string for blank string' do
      expect(helper.collection_entry_email('')).to eq('')
    end

    it 'returns string for nil' do
      expect(helper.collection_entry_email(nil)).to eq('')
    end

    it 'returns string for invalid email string' do
      expect(helper.collection_entry_email('this is not an email address')).to eq('this is not an email address')
    end
  end

  context 'with #collection_entry_url(value)' do
    it 'returns string for url string' do
      expect(helper.collection_entry_url('https://example.com')).to eq('https://example.com')
    end

    it 'returns string for url partial string' do
      expect(helper.collection_entry_url('example.com')).to eq('example.com')
    end

    it 'returns string for blank string' do
      expect(helper.collection_entry_url('')).to eq('')
    end

    it 'returns string for nil' do
      expect(helper.collection_entry_url(nil)).to eq('')
    end

    it 'returns string for invalid email string' do
      expect(helper.collection_entry_url('this is not a url')).to eq('this is not a url')
    end
  end

  context 'with #collection_entry_boolean(value)' do
    it 'returns boolean for boolean' do
      expect(helper.collection_entry_boolean(true)).to be(true)
    end

    it 'returns boolean for true string' do
      expect(helper.collection_entry_boolean('true')).to be(true)
    end

    it 'returns boolean for t string' do
      expect(helper.collection_entry_boolean('t')).to be(true)
    end

    it 'returns boolean for y string' do
      expect(helper.collection_entry_boolean('y')).to be(true)
    end

    it 'returns boolean for yes string' do
      expect(helper.collection_entry_boolean('yes')).to be(true)
    end

    it 'returns true for number 1 number' do
      expect(helper.collection_entry_boolean(1)).to be(true)
    end

    it 'returns true for number 1 string' do
      expect(helper.collection_entry_boolean('1')).to be(true)
    end

    it 'returns false for nil' do
      expect(helper.collection_entry_boolean(nil)).to be(false)
    end

    it 'returns false for everything else' do
      expect(helper.collection_entry_boolean('hello')).to be(false)
    end
  end

  context 'with #collection_entry_integer(value)' do
    it 'returns integer for number' do
      expect(helper.collection_entry_integer(1)).to eq(1)
    end

    it 'returns integer for number string' do
      expect(helper.collection_entry_integer('1')).to eq(1)
    end

    it 'returns whole number for decimal number' do
      expect(helper.collection_entry_integer('3.14')).to eq(3)
    end

    it 'returns zero for non-number' do
      expect(helper.collection_entry_integer('hello')).to eq(0)
    end
  end

  context 'with #collection_entry_datetime(value)' do
    it 'returns datetime string for datetime object' do
      expect(helper.collection_entry_datetime('2020-05-25 03:41:18'.to_datetime)).to eq('May 25, 2020 @ 03:41 AM')
    end

    it 'returns datetime string for datetime string' do
      expect(helper.collection_entry_datetime('2020-05-25 03:41:18')).to eq('May 25, 2020 @ 03:41 AM')
    end

    it 'returns datetime string for date string' do
      expect(helper.collection_entry_datetime('2020-05-25')).to eq('May 25, 2020 @ 12:00 AM')
    end

    it 'returns nil for blank string' do
      expect(helper.collection_entry_datetime('')).to be_nil
    end

    it 'returns nil for nil' do
      expect(helper.collection_entry_datetime(nil)).to be_nil
    end

    it 'returns nil for invalid datetime string' do
      expect(helper.collection_entry_datetime('not a date')).to be_nil
    end
  end

  context 'with #collection_entry_date(value)' do
    it 'returns date string for datetime object' do
      expect(helper.collection_entry_date('2020-05-25 03:41:18'.to_datetime)).to eq('May 25, 2020')
    end

    it 'returns date string for datetime string' do
      expect(helper.collection_entry_date('2020-05-25 03:41:18')).to eq('May 25, 2020')
    end

    it 'returns date string for date string' do
      expect(helper.collection_entry_date('2020-05-25')).to eq('May 25, 2020')
    end

    it 'returns nil for blank string' do
      expect(helper.collection_entry_date('')).to be_nil
    end

    it 'returns nil for nil' do
      expect(helper.collection_entry_date(nil)).to be_nil
    end

    it 'returns nil for invalid date string' do
      expect(helper.collection_entry_date('not a date')).to be_nil
    end
  end

  context 'with #collection_entry_time(value)' do
    it 'returns time string for datetime object' do
      expect(helper.collection_entry_time('2020-05-25 03:41:18'.to_datetime)).to eq('03:41 AM')
    end

    it 'returns time string for datetime string' do
      expect(helper.collection_entry_time('2020-05-25 03:41:18')).to eq('03:41 AM')
    end

    it 'returns time string for date string' do
      expect(helper.collection_entry_time('2020-05-25')).to eq('12:00 AM')
    end

    it 'returns time string for time string' do
      expect(helper.collection_entry_time('03:41:18')).to eq('03:41 AM')
    end

    it 'returns nil for blank string' do
      expect(helper.collection_entry_time('')).to be_nil
    end

    it 'returns nil for nil' do
      expect(helper.collection_entry_time(nil)).to be_nil
    end

    it 'returns nil for invalid datetime string' do
      expect(helper.collection_entry_time('not a date')).to be_nil
    end
  end
end
