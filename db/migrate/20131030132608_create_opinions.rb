class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
    	t.integer   :recipe_id,		:null => false
	    t.integer   :user_id,		:null => false
	    t.float     :rating,		:null => false
	    t.text      :opinion, 		:null => false
      	t.timestamps
    end
  end
end
