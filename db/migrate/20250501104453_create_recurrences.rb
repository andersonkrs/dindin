class CreateRecurrences < ActiveRecord::Migration[8.0]
  def change
    create_table :recurrences do |t|
      t.string :title
      t.date :start_on, null: false
      t.string :frequency, null: false
      t.integer :count, null: true

      t.timestamps
    end

    change_table :transactions, bulk: true do |t|
      t.belongs_to :recurrence, null: true, index: true
    end
  end
end
