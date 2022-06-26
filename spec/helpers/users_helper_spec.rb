# frozen_string_literal: true

RSpec.describe UsersHelper, type: :helper do
  context 'with #user_status(resource)' do
    let(:unconfirmed_user) { build(:user, :unconfirmed) }
    let(:locked_user) { build(:user, :locked) }
    let(:available_user) { build(:user) }

    it 'returns `unconfirmed` class' do
      expect(helper.user_status(unconfirmed_user)).to eq('unconfirmed')
    end

    it 'returns `locked` class' do
      expect(helper.user_status(locked_user)).to eq('locked')
    end

    it 'returns `available` class' do
      expect(helper.user_status(available_user)).to eq('available')
    end
  end
end
