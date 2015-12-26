class AddSourceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :source, :string
    add_column :recipes, :url_source, :string
  end
end
