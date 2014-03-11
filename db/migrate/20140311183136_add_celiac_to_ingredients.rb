class AddCeliacToIngredients < ActiveRecord::Migration
  def change
  	add_column :ingredients, :celiac, :boolean
  end
end
