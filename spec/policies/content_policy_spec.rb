# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContentPolicy, type: :policy do
  subject { described_class.new(user, resource) }

  let(:site) { create(:site) }
  let(:user) { create(:user) }
  let(:resource) { create(:content, site: site) }

  context 'with User under the `admin` role' do
    before { create(:user_site, :admin_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[index show destroy]) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_actions(%i[restore]) }
  end

  context 'with User under the `editor` role' do
    before { create(:user_site, :editor_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_actions(%i[destroy restore]) }
  end

  context 'with User under the `reader` role' do
    before { create(:user_site, :reader_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_actions(%i[destroy restore]) }
  end
end
