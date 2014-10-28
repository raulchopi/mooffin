class RemoveNullableOpinionOpinion < ActiveRecord::Migration
  def change
    change_column_null :opinions, :opinion, true
  end
end
