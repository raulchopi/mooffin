class AddWeightToImportances < ActiveRecord::Migration
  def change
    add_column :importances, :weight, :integer
  end
end
