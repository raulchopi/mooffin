class AddTextlinkToLinks < ActiveRecord::Migration
  def change
    add_column :links, :text_link, :string, :default => ''
  end
end
