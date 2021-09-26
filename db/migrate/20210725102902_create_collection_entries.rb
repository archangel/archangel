class CreateCollectionEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :collection_entries do |t|
      t.belongs_to :collection, foreign_key: true
      t.jsonb :content, null: false, default: "{}"
      t.integer :position, default: 0
      t.datetime :published_at
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :collection_entries, :content,     using: :gin
    add_index :collection_entries, :published_at
    add_index :collection_entries, :discarded_at
  end
end
