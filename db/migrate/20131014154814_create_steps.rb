# encoding: utf-8
class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
    	t.integer   :recipe_id,		:null => false
	    t.integer   :order,			:null => false
	    t.integer   :time,			:null => false
	    t.text		:description,	:null => false
      	t.timestamps
    end
  end
end
