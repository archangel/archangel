# frozen_string_literal: true

# Base policy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  %w[index show create update destroy].each do |rest_action|
    define_method("#{rest_action}?".to_sym) do
      false
    end
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  # class Scope
  #   attr_reader :user, :scope
  #
  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end
  #
  #   def resolve
  #     scope.all
  #   end
  # end

  protected

  UserSite::ROLES.each_key do |role|
    define_method("#{role}?".to_sym) do
      user.role == role.to_s
    end
  end
end
