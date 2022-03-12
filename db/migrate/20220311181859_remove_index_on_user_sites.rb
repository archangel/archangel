class RemoveIndexOnUserSites < ActiveRecord::Migration[6.0]
  def change
    remove_index :accounts, name: :index_user_sites_on_user_id
  end
end
