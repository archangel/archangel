class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.references :storable, polymorphic: true, index: true
      t.string :key, null: false
      t.string :value

      t.timestamps
    end

    add_index :stores, [:key, :storable_type, :storable_id], unique: true
  end
end
