class UpdateNotNullColumns < ActiveRecord::Migration[6.0]
  def change
    change_column_null :collection_entries, :collection_id, false
    change_column_null :collection_fields, :collection_id, false
    change_column_null :collections, :site_id, false
    change_column_null :contents, :site_id, false
    change_column_null :stores, :storable_id, false
  end
end
