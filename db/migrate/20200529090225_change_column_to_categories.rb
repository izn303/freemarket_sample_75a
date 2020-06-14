class ChangeColumnToCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :ancestry, :string, null: true
  end
end
