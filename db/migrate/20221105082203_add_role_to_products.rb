class AddRoleToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :pre_order, :boolean, default: false
    add_column :products, :stock_product, :boolean, default: false
  end
end
