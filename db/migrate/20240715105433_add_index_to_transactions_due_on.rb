class AddIndexToTransactionsDueOn < ActiveRecord::Migration[7.2]
  def change
    add_index :transactions, :due_on, order: { due_on: :desc }
  end
end
