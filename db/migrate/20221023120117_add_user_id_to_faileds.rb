class AddUserIdToFaileds < ActiveRecord::Migration[6.1]
  def change
    add_column :faileds, :user_id, :integer
    add_index :faileds, :user_id
    add_column :faileds, :product_id, :integer
    add_index :faileds, :product_id
  end
end
