class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name, :null => false
      t.string	:description
      t.timestamps
    end
  end
end
