class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      # t.integer :price
      t.float :price
      # t.decimal :price, precision: 5, scale: 2
      t.integer :quantity
      t.text :description

      t.timestamps
    end
  end
end
