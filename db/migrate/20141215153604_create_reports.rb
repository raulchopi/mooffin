class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer   :user_id, 		:null => false
      t.integer   :recipe_id,		:null => false
      t.integer   :reason_id,		:null => false
      t.text      :description
      t.timestamps
    end
  end
end
