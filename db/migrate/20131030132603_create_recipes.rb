class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
    	t.integer   :user_id, 		:null => false
	    t.string    :title, 		:null => false
	    t.integer   :difficulty,	:null => false
	    t.integer   :time, 			:null => false
	    t.integer   :servings, 		:null => false
	    t.text      :description, 	:null => false
	    t.float     :rating, 		:null => false
      	t.timestamps
    end
  end
end
