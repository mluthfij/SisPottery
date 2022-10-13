class CreateVessels < ActiveRecord::Migration[6.1]
  def change
    create_table :vessels do |t|
      # t.belongs_to :orderable, null: false, foreign_key: true
      t.belongs_to :history, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
