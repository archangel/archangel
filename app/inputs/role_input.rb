# frozen_string_literal: true

# Role select custom input type for SimpleForm
class RoleInput < SimpleForm::Inputs::CollectionSelectInput
  # Do not include blank select option
  #
  # @return [Boolean] skip blank select option
  def skip_include_blank?
    true
  end

  protected

  def collection
    @collection ||= resource_options
  end

  def resource_options
    [].tap do |option|
      UserSite.roles.keys.map do |role|
        option << [I18n.t("inputs.roles.#{role}", default: role.upcase), role]
      end
    end
  end
end
