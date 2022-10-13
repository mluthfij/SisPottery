class AddItemsToVessels < ActiveRecord::Migration[6.1]
  def change

    add_column :vessels, :price, :integer
    # add_column :vessels, :price, :decimal, precision: 15, scale: 2
    add_column :vessels, :quantity, :integer
    add_column :vessels, :order_at, :string
    add_column :vessels, :date, :date
  end
end
