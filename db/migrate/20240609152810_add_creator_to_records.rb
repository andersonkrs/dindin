class AddCreatorToRecords < ActiveRecord::Migration[7.2]
  def change
    add_reference :transactions, :creator, foreign_key: { to_table: :users }, index: true
    add_reference :categories, :creator, foreign_key: { to_table: :users }, index: true
  end
end
