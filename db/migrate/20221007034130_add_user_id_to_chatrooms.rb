class AddUserIdToChatrooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chatrooms, :user_id, :integer
    add_index :chatrooms, :user_id
  end
end
