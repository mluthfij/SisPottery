class AddDescriptionToVessels < ActiveRecord::Migration[6.1]
  def change
    add_column :vessels, :description, :string
    add_column :keeps, :description, :string
    add_column :faileds, :description, :string
  end
end
