# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ##
  # Attribute model translation
  #
  # Translate model attribute to active_record translation by using a nicer version of `human_attribute_name` method on
  # an instance.
  #
  # Example
  #   @page.attribute_translate(:title) => "Title"
  #   @pages.first.attribute_translate(:title) => "Title"
  #
  def attribute_translate(attr)
    self.class.human_attribute_name(attr)
  end
end
