class RemoveNullableLinksFields < ActiveRecord::Migration
  def change
    change_column_null :links, :unit_id, true
    change_column_null :links, :number, true
  end
end
