class InsertIngredients < ActiveRecord::Migration
  def self.up
    Ingredient.new(:name => "Lechuga")
    Ingredient.new(:name => "Tomate")
    Ingredient.new(:name => "Cebolla")
    Ingredient.new(:name => "Queso")
    Ingredient.new(:name => "Chorizo")
    Ingredient.new(:name => "Jamón")
  end
  def self.down
    Ingredient.delete_all()
  end
end