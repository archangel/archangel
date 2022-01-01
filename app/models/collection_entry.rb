# frozen_string_literal: true

class CollectionEntry < ApplicationRecord
  include EntryValidatableConcern
  include DeleteConcern
  include PublishConcern

  acts_as_list scope: :collection, top_of_list: 0, add_new_at: :top

  belongs_to :collection

  validates :content, presence: true

  protected

  def resource_value_fields
    return [] if try(:collection).try(:collection_fields).blank?

    collection.collection_fields
  end
end
