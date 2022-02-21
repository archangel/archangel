# frozen_string_literal: true

RSpec.describe SitePolicy, type: :policy do
  subject { described_class.new(user, resource) }

  let(:site) { create(:site) }
  let(:user) { create(:user) }
  let(:resource) { site }

  context 'with User under the `admin` role' do
    before { create(:user_site, :admin_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_actions(%i[index destroy]) }
    it { is_expected.to permit_actions(%i[switch]) }
  end

  context 'with User under the `editor` role' do
    before { create(:user_site, :editor_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_actions(%i[index destroy]) }
    it { is_expected.to permit_actions(%i[switch]) }
  end

  context 'with User under the `reader` role' do
    before { create(:user_site, :reader_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_actions(%i[index destroy]) }
    it { is_expected.to permit_actions(%i[switch]) }
  end
end
