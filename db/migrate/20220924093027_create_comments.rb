class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      # t.string :name
      t.string :reply_to
      t.text :content
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
