class RenameItemStatusColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :item_status, :item_status_id
  end
end
