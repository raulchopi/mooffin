class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
    	t.integer   :recipe_id, 		:null => false
	    t.integer   :ingredient_id,		:null => false
	    t.integer   :importance, 		:null => false
	    t.integer   :unit_id, 			:null => false
	    t.float     :number, 			:null => false
	    t.timestamps
    end
  end
end
