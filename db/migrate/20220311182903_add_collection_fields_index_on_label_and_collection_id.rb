class AddCollectionFieldsIndexOnLabelAndCollectionId < ActiveRecord::Migration[6.0]
  def change
    add_index :collection_fields, [:label, :collection_id], unique: true
  end
end
