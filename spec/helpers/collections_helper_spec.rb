# frozen_string_literal: true

RSpec.describe CollectionsHelper, type: :helper do
  context 'with #collection_status(resource)' do
    let(:discarded_collection) { build(:collection, :discarded) }
    let(:draft_collection) { build(:collection, :unpublished) }
    let(:scheduled_collection) { build(:collection, :scheduled) }
    let(:available_collection) { build(:collection) }

    it 'returns `deleted` class' do
      expect(helper.collection_status(discarded_collection)).to eq('deleted')
    end

    it 'returns `draft` class' do
      expect(helper.collection_status(draft_collection)).to eq('draft')
    end

    it 'returns `scheduled` class' do
      expect(helper.collection_status(scheduled_collection)).to eq('scheduled')
    end

    it 'returns `available` class' do
      expect(helper.collection_status(available_collection)).to eq('available')
    end
  end
end
