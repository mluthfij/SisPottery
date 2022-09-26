class AddFullnameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :my_address, :text
    add_column :users, :phone, :integer
    add_column :users, :wa_phone, :integer
  end
end
