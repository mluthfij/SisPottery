class AddUserIdToOrderable < ActiveRecord::Migration[6.1]
  def change
    add_column :orderables, :user_id, :integer
    add_index :orderables, :user_id
  end
end
