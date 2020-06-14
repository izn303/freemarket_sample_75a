class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url, null: false
      #t.reference:item,null:fals, foregin_key:true
      #itemモデルが存在しないので、外部キーとして追加できない
      t.timestamps
    end
  end
end
