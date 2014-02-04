class CreateImportances < ActiveRecord::Migration
  def change
    create_table :importances do |t|
    	t.string    :desc, 	:null => false
      	t.timestamps
    end
  end
end
