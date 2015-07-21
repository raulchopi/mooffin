class AddUniqueIndexToRecipeCats < ActiveRecord::Migration
  def change
    add_index :recipecats, [:recipe_id, :category_id], unique: true
  end
end
