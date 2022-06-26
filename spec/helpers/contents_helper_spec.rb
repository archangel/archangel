# frozen_string_literal: true

RSpec.describe ContentsHelper, type: :helper do
  context 'with #content_status(resource)' do
    let(:discarded_content) { build(:content, :discarded) }
    let(:draft_content) { build(:content, :unpublished) }
    let(:scheduled_content) { build(:content, :scheduled) }
    let(:available_content) { build(:content) }

    it 'returns `deleted` class' do
      expect(helper.content_status(discarded_content)).to eq('deleted')
    end

    it 'returns `draft` class' do
      expect(helper.content_status(draft_content)).to eq('draft')
    end

    it 'returns `scheduled` class' do
      expect(helper.content_status(scheduled_content)).to eq('scheduled')
    end

    it 'returns `available` class' do
      expect(helper.content_status(available_content)).to eq('available')
    end
  end
end
