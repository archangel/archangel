# frozen_string_literal: true

class CollectionEntry < ApplicationRecord
  acts_as_list scope: :collection, top_of_list: 0

  belongs_to :collection

  validates :content, presence: true
end
