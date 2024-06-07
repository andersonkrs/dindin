class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :kind, null: false

      t.index [:ind, :title], unique: true

      t.timestamps
    end
  end
end
