class CreateCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :site, foreign_key: true
      t.datetime :published_at
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :collections, [:slug, :site_id], unique: true
    add_index :collections, :published_at
    add_index :collections, :discarded_at
  end
end
