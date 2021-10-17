# frozen_string_literal: true

module FlashHelper
  def flash_class_for(flash_type)
    flash_type = flash_type.to_s.downcase.parameterize

    { alert: 'warning', notice: 'info' }.fetch(flash_type.to_sym, flash_type)
  end
end
