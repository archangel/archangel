class AddColumnsToVersions < ActiveRecord::Migration[6.0]
  def change
    add_column :versions, :origin, :string
    add_column :versions, :ip, :inet
    add_column :versions, :user_agent, :string
  end
end
