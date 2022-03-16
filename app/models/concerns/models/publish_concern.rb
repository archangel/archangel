# frozen_string_literal: true

# Model concern
module Models
  # Publish concern
  #
  # Example
  #   class Example < ApplicationRecord
  #     include Models::PublishConcern
  #   end
  module PublishConcern
    extend ActiveSupport::Concern

    included do
      class_attribute :published_column
      self.published_column = :published_at

      # Available scope
      #
      # Retrieve only available resources
      #
      # Example
      #   class PagesController < AdminController
      #     def index
      #       @examples = Example.available
      #     end
      #   end
      scope :available, -> { where("#{published_column} <= ?", Time.current) }

      # Published scope
      #
      # Retrieve only published resources
      #
      # Example
      #   class PagesController < AdminController
      #     def index
      #       @examples = Example.published
      #     end
      #   end
      scope :published, -> { where.not(published_column => nil) }

      # Scheduled scope
      #
      # Retrieve only scheduled resources
      #
      # Example
      #   class PagesController < AdminController
      #     def index
      #       @examples = Example.scheduled
      #     end
      #   end
      scope :scheduled, -> { where("#{published_column} > ?", Time.current) }

      # Unpublished scope
      #
      # Retrieve only unpublished resources
      #
      # Example
      #   class PagesController < AdminController
      #     def index
      #       @examples = Example.unpublished
      #     end
      #   end
      scope :unpublished, -> { where(published_column => nil) }
    end

    # Published check
    #
    # Check if an item is published based on the presence of a value in the published column. This does not take into
    # account whether the item is not currently available (scheduled). See module documentation for more information
    #
    # @example When resource is published
    #   @example.published? => true
    #
    # @example When resource is not published
    #   @example.published? => false
    #
    # @return [Boolean] if resource is published
    def published?
      self[self.class.published_column].present?
    end

    # Scheduled check
    #
    # Check if an item is scheduled based on the future presence of a value in the published column.
    #
    # @example When resource is scheduled
    #   @example.scheduled? => true
    #
    # @example When resource is not scheduled
    #   @example.scheduled? => false
    #
    # @return [Boolean] if resource is scheduled
    def scheduled?
      published? && self[self.class.published_column] > Time.current
    end

    # Unpublished check
    #
    # Check if an item is unpublished based on the lack of presence of a value in the published column.
    #
    # @example When resource is not published
    #   @example.draft? => true
    #
    # @example When resource is published
    #   @example.draft? => false
    #
    # @return [Boolean] if resource is unpublished
    def unpublished?
      self[self.class.published_column].blank?
    end
  end
end
