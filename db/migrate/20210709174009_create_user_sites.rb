class CreateUserSites < ActiveRecord::Migration[6.1]
  def change
    create_table :user_sites do |t|
      t.bigint :user_id, null: false
      t.bigint :site_id, null: false
      t.integer :role,   null: false, default: 0

      t.timestamps
    end

    add_index :user_sites, :user_id
    add_index :user_sites, :site_id
    add_index :user_sites, [:user_id, :site_id]
  end
end
