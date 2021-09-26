# frozen_string_literal: true

class CollectionField < ApplicationRecord
  acts_as_list scope: :collection, top_of_list: 0

  after_initialize :assign_default_values

  CLASSIFICATIONS = {
    string: 0,
    integer: 1,
    boolean: 2,
    datetime: 3,
    date: 4,
    time: 5
  }.freeze

  CLASSIFICATION_DEFAULT = 0

  enum classification: CLASSIFICATIONS

  belongs_to :collection

  validates :classification, presence: true, inclusion: { in: classifications.keys }
  validates :key, presence: true, uniqueness: { scope: :collection_id }
  validates :label, presence: true
  validates :required, inclusion: { in: [true, false] }

  protected

  def assign_default_values
    self.classification = CLASSIFICATION_DEFAULT if classification.blank?
  end
end
