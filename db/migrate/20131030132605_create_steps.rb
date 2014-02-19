# encoding: utf-8
class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
    	t.integer   :recipe_id,		:null => false
	    t.integer   :orden,			:null => false
	    t.text		:description,	:null => false
	    t.integer   :time	    
      	t.timestamps
    end
  end
end
