# frozen_string_literal: true

# Version model
class Version < PaperTrail::Version
  self.table_name = :versions

  belongs_to :item, polymorphic: true, counter_cache: true

  belongs_to :collection, foreign_key: :item_id, optional: true, inverse_of: :versions
  belongs_to :collection_entry, foreign_key: :item_id, optional: true, inverse_of: :versions
  belongs_to :content, foreign_key: :item_id, optional: true, inverse_of: :versions
  belongs_to :site, foreign_key: :item_id, optional: true, inverse_of: :versions
  belongs_to :user, foreign_key: :item_id, optional: true, inverse_of: :versions

  belongs_to :user, foreign_key: :whodunnit, optional: true, inverse_of: :versions
end
