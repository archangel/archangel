# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe '.email' do
      let(:record) { build(:user) }

      it 'is not valid without tld in email' do
        record.email = 'foo'

        expect(record).not_to be_valid
      end

      it 'is not valid without extension in email' do
        record.email = 'foo@bar'

        expect(record).not_to be_valid
      end

      it 'is not valid with spacial characters in email' do
        record.email = 'foo bar@email.com'

        expect(record).not_to be_valid
      end

      it 'fails with validation message' do
        record.email = 'foo@bar'
        record.validate

        expect(record.errors.full_messages).to eq ['Email is not a valid email']
      end
    end

    describe '.username' do
      let(:record) { build(:user) }

      it 'is not valid with space in username' do
        record.username = 'hello world'

        expect(record).not_to be_valid
      end

      it 'is not valid with spacial characters in key' do
        record.username = 'foo*bar'

        expect(record).not_to be_valid
      end

      it 'is not valid with upper case letters in key' do
        record.username = 'fooBar'

        expect(record).not_to be_valid
      end

      it 'fails with validation message' do
        record.username = 'hello world'
        record.validate

        expect(record.errors.full_messages).to eq ['Username is not a valid slug']
      end
    end
  end
end
