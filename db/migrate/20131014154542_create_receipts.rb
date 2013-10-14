class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|

      t.timestamps
    end
  end
end
