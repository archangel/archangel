# frozen_string_literal: true

# CollectionEntry model
class CollectionEntry < ApplicationRecord
  include Models::EntryValidatableConcern
  include Models::DeleteConcern
  include Models::PublishConcern
  include Models::PaperTrailConcern

  acts_as_list scope: :collection, top_of_list: 0, add_new_at: :top

  belongs_to :collection

  has_many :versions, class_name: 'PaperTrail::Version', foreign_key: :item_id, dependent: :destroy

  validates :content, presence: true

  protected

  def resource_value_fields
    return [] if try(:collection).try(:collection_fields).blank?

    collection.collection_fields
  end
end
