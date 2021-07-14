class CreateMetatags < ActiveRecord::Migration[6.1]
  def change
    create_table :metatags do |t|
      t.references :metatagable, polymorphic: true, index: true
      t.string :name, null: false
      t.string :content

      t.timestamps
    end

    add_index :metatags, [:name, :metatagable_type, :metatagable_id], unique: true, name: 'index_metatags_on_name_and_tagable_type_and_tagable_id'
  end
end
