class CreateRecipecats < ActiveRecord::Migration
  def change
    create_table :recipecats do |t|
      t.integer   :recipe_id, 		:null => false
	    t.integer   :category_id,		:null => false
      t.timestamps
    end
  end
end
