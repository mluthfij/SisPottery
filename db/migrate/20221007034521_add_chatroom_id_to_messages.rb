class AddChatroomIdToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :chatroom_id, :integer
    add_index :messages, :chatroom_id
  end
end
