# frozen_string_literal: true

##
# Classification select custom input for SimpleForm
#
class ClassificationInput < SimpleForm::Inputs::CollectionSelectInput
  ##
  # Do not include blank select option
  #
  # @return [Boolean] to skip blank select option
  #
  def skip_include_blank?
    true
  end

  protected

  def collection
    @collection ||= resource_options
  end

  def resource_options
    [].tap do |option|
      CollectionField.classifications.keys.map do |classification|
        option << [I18n.t("classifications.#{classification}", default: classification.upcase), classification]
      end
    end
  end
end
