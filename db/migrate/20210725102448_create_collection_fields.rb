class CreateCollectionFields < ActiveRecord::Migration[6.1]
  def change
    create_table :collection_fields do |t|
      t.string :label, null: false
      t.string :key, null: false
      t.belongs_to :collection, foreign_key: true
      t.integer :classification, null: false, default: 0
      t.boolean :required, default: false
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :collection_fields, [:key, :collection_id], unique: true
  end
end
