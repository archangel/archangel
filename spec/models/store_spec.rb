# frozen_string_literal: true

RSpec.describe Store, type: :model do
  describe 'validations' do
    describe '.key' do
      let(:record) { build(:store) }

      it 'is not valid with PascalCase key' do
        record.key = 'FooBar'

        expect(record).not_to be_valid
      end

      it 'is not valid with dash in key' do
        record.key = 'foo-bar'

        expect(record).not_to be_valid
      end

      it 'is not valid with underscore in key' do
        record.key = 'foo_bar'

        expect(record).not_to be_valid
      end

      it 'is not valid with special character in key' do
        record.key = 'foo@Bar'

        expect(record).not_to be_valid
      end

      it 'is not valid with non-letter as first character in key' do
        record.key = '2fooBar'

        expect(record).not_to be_valid
      end

      it 'fails with validation message' do
        record.key = 'FooBar'
        record.validate

        expect(record.errors.full_messages).to eq ['Key must be camel case (eg. camelCase)']
      end
    end
  end
end
