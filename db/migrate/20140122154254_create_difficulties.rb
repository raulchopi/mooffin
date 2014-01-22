class CreateDifficulties < ActiveRecord::Migration
  def change
    create_table :difficulties do |t|
    	t.string    :desc, 	:null => false
		t.timestamps
    end
  end
end
