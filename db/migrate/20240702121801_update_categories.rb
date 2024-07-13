class UpdateCategories < ActiveRecord::Migration[7.2]
  def change
    change_table :categories, bulk: true do |t|
      t.change :kind, :string, null: false

      t.remove_index [:title, :kind]
      t.index [:kind, :title], unique: true
      t.check_constraint "kind in ('expense', 'income')"
    end
  end
end
