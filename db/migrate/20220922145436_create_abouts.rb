class CreateAbouts < ActiveRecord::Migration[6.1]
  def change
    create_table :abouts do |t|
      t.text :description
      t.string :company_name
      # t.string :sub_title
      t.date :sub_title
      t.string :title

      t.timestamps
    end
  end
end
