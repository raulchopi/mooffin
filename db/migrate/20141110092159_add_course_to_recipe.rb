class AddCourseToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :course_id, :integer
  end
end
