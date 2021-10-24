# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Profile permissions', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    sign_in(profile)
  end

  describe 'with `admin` role' do
    before do
      create(:user_site, :admin_role, user: profile, site: site)
    end

    describe 'with #show' do
      before { visit '/manage/profile' }

      it 'allows access' do
        expect(page.status_code).to eq(200)
      end
    end

    describe 'with #edit' do
      before { visit '/manage/profile/edit' }

      it 'allows access' do
        expect(page.status_code).to eq(200)
      end
    end
  end

  describe 'with `editor` role' do
    before do
      create(:user_site, :editor_role, user: profile, site: site)
    end

    describe 'with #show' do
      before { visit '/manage/profile' }

      it 'allows access' do
        expect(page.status_code).to eq(200)
      end
    end

    describe 'with #edit' do
      before { visit '/manage/profile/edit' }

      it 'allows access' do
        expect(page.status_code).to eq(200)
      end
    end
  end

  describe 'with `reader` role' do
    before do
      create(:user_site, :reader_role, user: profile, site: site)
    end

    describe 'with #show' do
      before { visit '/manage/profile' }

      it 'allows access' do
        expect(page.status_code).to eq(200)
      end
    end

    describe 'with #edit' do
      before { visit '/manage/profile/edit' }

      it 'allows access' do
        expect(page.status_code).to eq(200)
      end
    end
  end
end
