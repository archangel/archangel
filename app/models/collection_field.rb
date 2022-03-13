# frozen_string_literal: true

# CollectionField model
class CollectionField < ApplicationRecord
  acts_as_list scope: :collection, top_of_list: 0

  after_initialize :assign_default_values

  CLASSIFICATIONS = {
    string: 0,
    text: 1,
    email: 2,
    url: 3,
    integer: 4,
    boolean: 5,
    datetime: 6,
    date: 7,
    time: 8
  }.freeze

  CLASSIFICATION_DEFAULT = 0

  enum classification: CLASSIFICATIONS

  belongs_to :collection

  validates :classification, presence: true, inclusion: { in: classifications.keys }
  validates :key, presence: true, camel_case: true, uniqueness: { scope: :collection_id }
  validates :label, presence: true, uniqueness: { scope: :collection_id }
  validates :required, inclusion: { in: [true, false] }

  protected

  def assign_default_values
    self.classification = CLASSIFICATION_DEFAULT if classification.blank?
  end
end
