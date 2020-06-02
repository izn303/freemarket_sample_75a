class RenameShipmentDateColumToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :shipment_date, :shipment_date_id
    rename_column :items, :shipment_pref, :shipment_pref_id
    rename_column :items, :shipment_fee, :shipment_fee_id
  end
end