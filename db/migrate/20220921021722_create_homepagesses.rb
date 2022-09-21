class CreateHomepagesses < ActiveRecord::Migration[6.1]
  def change
    create_table :homepagesses do |t|
      t.string :brand_name
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
