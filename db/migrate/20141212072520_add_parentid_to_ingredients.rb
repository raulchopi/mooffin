class AddParentidToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :parent_id, :integer
  end
end
