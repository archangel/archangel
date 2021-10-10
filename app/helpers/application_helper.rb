# frozen_string_literal: true

module ApplicationHelper
  ##
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
  # Example
  #   <%= html_dir %> #=> 'ltr'
  #   <%= html_dir %> #=> 'rtl'
  #
  def html_dir
    rtl_languages = %w[am ar az dv ff he ku fa ur]

    rtl_languages.include?(html_lang) ? 'rtl' : 'ltr'
  end

  ##
  # Lang locale
  #
  # The `lang` value for the `html` tag. Returns the first two characters of the identified language.
  #
  # Example
  #   <%= html_lang %> #=> 'en'
  #   <%= html_lang %> #=> 'fr'
  #
  def html_lang
    I18n.locale.to_s.scan(/^[a-z]{2}/).first
  end
end
