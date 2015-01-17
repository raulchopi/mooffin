class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string  :description,		:null => false
    end
  end
end
