class AddUserIdToBuckets < ActiveRecord::Migration[6.1]
  def change
    add_column :buckets, :user_id, :integer
    add_index :buckets, :user_id
  end
end
