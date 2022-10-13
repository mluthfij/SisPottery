class CreateKeeps < ActiveRecord::Migration[6.1]
  def change
    create_table :keeps do |t|
      # t.belongs_to :vessel, null: false, foreign_key: true
      t.belongs_to :bucket, null: false, foreign_key: true
      t.string :customer
      t.string :product_name
      t.integer :product_price
      t.integer :quantity
      t.integer :total_price
      t.date :order_start
      t.date :order_end

      t.integer :point
      
      

      t.timestamps
    end
  end
end
