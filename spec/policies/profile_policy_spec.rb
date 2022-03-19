# frozen_string_literal: true

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class.new(user, resource) }

  let(:site) { create(:site) }
  let(:user) { create(:user) }
  let(:resource) { user }

  context 'with User under the `admin` role' do
    before { create(:user_site, :admin_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show edit update retoken]) }
    it { is_expected.to forbid_actions(%i[index new create destroy]) }
  end

  context 'with User under the `editor` role' do
    before { create(:user_site, :editor_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show edit update retoken]) }
    it { is_expected.to forbid_actions(%i[index new create destroy]) }
  end

  context 'with User under the `reader` role' do
    before { create(:user_site, :reader_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show edit update retoken]) }
    it { is_expected.to forbid_actions(%i[index new create destroy]) }
  end
end
