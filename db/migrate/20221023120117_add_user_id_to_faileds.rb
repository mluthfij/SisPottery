class AddUserIdToFaileds < ActiveRecord::Migration[6.1]
  def change
    add_column :faileds, :user_id, :integer
    add_index :faileds, :user_id
  end
end
