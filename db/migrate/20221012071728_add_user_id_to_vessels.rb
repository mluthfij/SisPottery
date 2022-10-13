class AddUserIdToVessels < ActiveRecord::Migration[6.1]
  def change
    add_column :vessels, :user_id, :integer
    add_index :vessels, :user_id
  end
end
