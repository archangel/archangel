# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  after do
    I18n.available_locales = %i[en]
    I18n.locale = :en
  end

  context 'with #html_dir' do
    it 'returns default dir' do
      expect(helper.html_dir).to eq('ltr')
    end

    it 'returns rtl dir' do
      I18n.available_locales = %i[en he]
      I18n.locale = :he

      expect(helper.html_dir).to eq('rtl')
    end
  end

  context 'with #html_lang' do
    it 'returns default lang' do
      expect(helper.html_lang).to eq('en')
    end

    it 'returns two character lang' do
      I18n.available_locales = %i[en-US en]
      I18n.locale = 'en-US'

      expect(helper.html_lang).to eq('en')
    end

    it 'returns French lang' do
      I18n.available_locales = %i[en fr]
      I18n.locale = :fr

      expect(helper.html_lang).to eq('fr')
    end
  end
end
