class CreateRecipes < ActiveRecord::Migration
	def change
		create_table :recipes do |t|
			t.integer   :user_id, 		:null => false
			t.string    :title, 		:null => false
			t.integer   :difficulty_id,	:null => false
			t.integer   :time, 			:null => false
			t.integer   :servings, 		:null => false
			t.text      :description, 	:default => ''
			t.float     :rating, 		:default => 0
			t.integer	:views_count, 	:default => 0
			t.timestamps
		end
	end
end
