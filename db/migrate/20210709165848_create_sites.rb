class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.string :name,  null: false, default: ""
      t.string :token, null: false

      t.timestamps
    end

    add_index :sites, :name,  unique: true
    add_index :sites, :token, unique: true
  end
end
