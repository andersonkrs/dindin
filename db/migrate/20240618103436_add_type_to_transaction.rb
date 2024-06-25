class AddTypeToTransaction < ActiveRecord::Migration[7.2]
  def change
    change_table :transactions, bulk: true do |t|
      t.string :type, null: true, index: true

      t.check_constraint "type in ('Expense', 'Income')"
    end

    execute "UPDATE transactions SET type = 'Expense';"

    change_column_null :transactions, :type, false
  end
end
