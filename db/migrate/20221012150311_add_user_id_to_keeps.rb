class AddUserIdToKeeps < ActiveRecord::Migration[6.1]
  def change
    add_column :keeps, :user_id, :integer
    add_index :keeps, :user_id
    # 
    add_column :keeps, :product_id, :integer
    add_index :keeps, :product_id
    # 
  end
end
