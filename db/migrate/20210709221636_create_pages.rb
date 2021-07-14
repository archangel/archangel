class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.references :site, foreign_key: true
      t.string :title, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.datetime :published_at
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :pages, [:slug, :site_id], unique: true
    add_index :pages, :published_at
    add_index :pages, :discarded_at
  end
end
