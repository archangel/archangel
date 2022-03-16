# frozen_string_literal: true

# Controller concern
module Controllers
  # Action helpers
  #
  # Helpers for the controller or view to help identify the action
  #
  # Example
  #   class ExamplesController < ApplicationController
  #     include Controllers::ActionConcern
  #   end
  module ActionConcern
    extend ActiveSupport::Concern

    included do
      helper_method :action?,
                    :collection_action?,
                    :create_action?,
                    :create_actions?,
                    :destroy_action?,
                    :edit_action?,
                    :edit_actions?,
                    :index_action?,
                    :member_action?,
                    :new_action?,
                    :new_actions?,
                    :show_action?,
                    :update_action?,
                    :update_actions?
    end

    # Check action
    #
    # Check if action is a certain action type
    #
    # @example With action string
    #   action?('show') # true
    #
    # @example With action symbol
    #   action?(:show) # true
    #
    # @param [String,Symbol] action_method the action to test
    # @return [Boolean] if action matches
    def action?(action_method)
      action == action_method.to_sym
    end

    # Check if action
    #
    # Check if action is action type. The check will pass if it is the action
    #
    # @example When requesting the `index` action
    #   index_action? #=> true
    #
    # @example When requesting the `show` action
    #   show_action? #=> true
    #
    # @example When requesting the `new` action
    #   new_action? #=> true
    #
    # @example When requesting the `create` action
    #   create_action? #=> true
    #
    # @example When requesting the `edit` action
    #   edit_action? #=> true
    #
    # @example When requesting the `update` action
    #   update_action? #=> true
    #
    # @example When requesting the `destroy` action
    #   destroy_action? #=> true
    #
    # @return [Boolean] if action is action type
    %w[index show new create edit update destroy].each do |rest_action|
      define_method("#{rest_action}_action?".to_sym) do
        action?(rest_action)
      end
    end

    # Check if collection
    #
    # Check if action is a collection action type. An action is a collection type if it is the `index` action
    #
    # @example When requesting a collection action
    #   collection_action? #=> true
    #
    # @example When not requesting a collection action
    #   collection_action? #=> false
    #
    # @return [Boolean] if action is collection type
    def collection_action?
      collection_actions.include?(action)
    end

    # Check if create or new
    #
    # Check if action is a create or new action type. The check will pass if it is a `create` or `new` action
    #
    # @example When requesting a `new` or `create` action
    #   create_actions? #=> true
    #   new_actions? #=> true
    #
    # @example When not requesting a `new` or `create` action
    #   create_actions? #=> false
    #   new_actions? #=> false
    #
    # @return [Boolean] if action is actions type
    def create_actions?
      create_actions.include?(action)
    end
    alias new_actions? create_actions?

    # Check if member
    #
    # Check if action is a member action type. An action is a member type if it is the `edit`, `show`, or `update`
    # action
    #
    # @example When requesting a member action
    #   member_action? #=> true
    #
    # @example When not requesting a member action
    #   member_action? #=> false
    #
    # @return [Boolean] if action is member type
    def member_action?
      member_actions.include?(action)
    end

    # Check if edit or update
    #
    # Check if action is an edit or update action type. The check will pass if it is an `edit` or `update` action
    #
    # @example When requesting a `edit` or `update` action
    #   update_actions? #=> true
    #   edit_actions? #=> true
    #
    # @example When not requesting a `edit` or `update` action
    #   update_actions? #=> false
    #   edit_actions? #=> false
    #
    # @return [Boolean] if action is actions type
    def update_actions?
      update_actions.include?(action)
    end
    alias edit_actions? update_actions?

    protected

    # Action symbol
    #
    # Take `action_name` (string) and turn it into a symbol
    def action
      action_name.to_sym
    end

    # Collection actions
    def collection_actions
      %i[index]
    end

    # Member actions
    def member_actions
      %i[edit show update]
    end

    # Create actions
    def create_actions
      %i[create new]
    end

    # Update actions
    def update_actions
      %i[edit update]
    end
  end
end
