# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSitePolicy, type: :policy do
  subject { described_class.new(user, resource) }

  let(:site) { create(:site) }
  let(:user) { create(:user) }

  context 'with User under the `admin` role' do
    let(:resource) { create(:user_site, :admin_role, user: user, site: site) }

    it { is_expected.to permit_actions(%i[destroy]) }
  end

  context 'with User under the `editor` role' do
    let(:resource) { create(:user_site, :editor_role, user: user, site: site) }

    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context 'with User under the `reader` role' do
    let(:resource) { create(:user_site, :reader_role, user: user, site: site) }

    it { is_expected.to forbid_actions(%i[destroy]) }
  end
end
