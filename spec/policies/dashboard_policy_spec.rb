# frozen_string_literal: true

RSpec.describe DashboardPolicy, type: :policy do
  subject { described_class.new(user, resource) }

  let(:site) { create(:site) }
  let(:user) { create(:user) }
  let(:resource) { :dashboard }

  context 'with User under the `admin` role' do
    before { create(:user_site, :admin_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[index new create edit update destroy]) }
  end

  context 'with User under the `editor` role' do
    before { create(:user_site, :editor_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[index new create edit update destroy]) }
  end

  context 'with User under the `reader` role' do
    before { create(:user_site, :reader_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[index new create edit update destroy]) }
  end
end
