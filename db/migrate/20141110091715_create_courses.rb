class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string    :description, 	:null => false
      t.timestamps
    end
  end
end
