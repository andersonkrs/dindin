class AddColorAndIconToCategories < ActiveRecord::Migration[7.2]
  def change
    change_table :categories, bulk: true do |t|
      t.string :icon, null: true
      t.string :color, null: true
    end
  end
end
