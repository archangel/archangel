# frozen_string_literal: true

# Flash message helpers
module FlashHelper
  # Flash HTML class
  #
  # Identify flash message type and transform as a Bootstrap HTML class
  #
  # @example With Rails 'alert' flash type
  #   <%= flash_class_for('alert') %> #=> 'warning'
  #
  # @example With Rails 'notice' flash type
  #   <%= flash_class_for('notice') %> #=> 'info'
  #
  # @example With Rails 'success' flash type
  #   <%= flash_class_for('success') %> #=> 'success'
  #
  # @example With unidentified flash type
  #   <%= flash_class_for('Cool') %> #=> 'cool'
  #
  # @param [String] flash_type type of flash message
  # @return [String] flash class
  def flash_class_for(flash_type)
    flash_type = flash_type.to_s.downcase.parameterize

    { alert: 'warning', notice: 'info' }.fetch(flash_type.to_sym, flash_type)
  end
end
