class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.string :name,          null: false, default: ""
      t.string :subdomain,     null: false
      t.jsonb :settings,       null: false, default: "{}"
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :sites, :name,        unique: true
    add_index :sites, :subdomain,   unique: true
    add_index :sites, :settings,               using: :gin
    add_index :sites, :discarded_at
  end
end
