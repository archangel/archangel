# frozen_string_literal: true

# Application helpers
module ApplicationHelper
  # Text direction
  #
  # The `dir` value for the `html` tag. Display text left-to-right for all languages but a few languages which should
  # display as right-to-left. Currently only returns 'rtl' for the following languages:
  #   Aramaic (Amharic)
  #   Arabic
  #   Azeri (Azerbaijani)
  #   Divehi, Dhivehi, Maldivian
  #   Fula, Fulah, Pulaar, Pular
  #   Hebrew
  #   Kurdish
  #   Persian (Farsi)
  #   Urdu
  #
  # @example With left-to-right language
  #   <%= html_dir %> #=> 'ltr'
  #
  # @example With right-to-left language
  #   <%= html_dir %> #=> 'rtl'
  #
  # @return [String] language director
  def html_dir
    rtl_languages = %w[am ar az dv ff he ku fa ur]

    rtl_languages.include?(html_lang) ? 'rtl' : 'ltr'
  end

  # Lang locale
  #
  # The `lang` value for the `html` tag. Returns the first two characters of the identified language.
  #
  # @example With English (default) as the language
  #   <%= html_lang %> #=> 'en'
  #
  # @example With French as the language
  #   <%= html_lang %> #=> 'fr'
  #
  # @return [String] locale
  def html_lang
    I18n.locale.to_s.scan(/^[a-z]{2}/).first
  end
end
