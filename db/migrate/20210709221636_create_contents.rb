class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :site, foreign_key: true
      t.text :body
      t.datetime :published_at
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :contents, [:slug, :site_id], unique: true
    add_index :contents, :published_at
    add_index :contents, :discarded_at
  end
end
