class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.string :title, null: false, index: true

      t.timestamps
    end
  end
end
