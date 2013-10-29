class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.integer   :recipe_id,		:null => false
    	t.integer   :user_id, 		:null => false    
      	t.timestamps
    end
  end
end
