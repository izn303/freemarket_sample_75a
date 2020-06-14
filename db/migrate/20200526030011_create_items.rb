class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string      :name,            null: false
      t.text        :introduction,    null: false
      t.integer     :price,           null: false
      t.string      :shipment_date,   null: false
      t.string      :shipment_pref,   null: false
      t.references  :category,        foreign_key: true, null: false
      t.string      :brand         
      t.string      :item_status,     null: false
      t.string      :shipment_fee,    null: false
      #t.references   :seller,          foreign_key: true, null: false
      #t.references   :buyer,           foreign_key: true,
      t.timestamps
    end
  end
end