# frozen_string_literal: true

# CollectionEntry model
class CollectionEntry < ApplicationRecord
  include Models::EntryValidatableConcern
  include Models::DeleteConcern
  include Models::PublishConcern

  acts_as_list scope: :collection, top_of_list: 0, add_new_at: :top

  has_paper_trail ignore: %i[updated_at]

  belongs_to :collection

  has_many :versions, -> { where(item_type: 'CollectionEntry').order(created_at: :desc) },
           foreign_key: :item_id, inverse_of: :collection_entry, dependent: :destroy

  validates :content, presence: true

  protected

  def resource_value_fields
    return [] if try(:collection).try(:collection_fields).blank?

    collection.collection_fields
  end
end
