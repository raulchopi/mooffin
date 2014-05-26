class CreateIngredients < ActiveRecord::Migration
	def change
		create_table :ingredients do |t|
			t.string    :name, 		:null => false
			t.boolean	:celiac,	:null => false
			t.boolean	:vegetarian,:null => false
			t.timestamps
		end
	end
end
