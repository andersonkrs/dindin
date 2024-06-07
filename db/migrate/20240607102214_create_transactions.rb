class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :title, index: true, null: false
      t.date :due_on, null: false
      t.date :paid_at
      t.monetize :value, null: false, default: nil
      t.references :category, null: false, foreign_key: true, index: true
      t.references :account, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
