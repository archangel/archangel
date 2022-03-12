class UpdateForeignKeyColumns < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :user_sites, :users
    add_foreign_key :user_sites, :sites
  end
end
