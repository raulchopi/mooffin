class AddPhotoToRecipe < ActiveRecord::Migration
  def self.up
    add_attachment :recipes, :photo
  end

  def self.down
    remove_attachment :recipes, :photo
  end
end