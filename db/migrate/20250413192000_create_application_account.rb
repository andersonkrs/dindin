class CreateApplicationAccount < ActiveRecord::Migration[8.0]
  def change
    create_table :app_accounts do |t|
      t.string :name, null: false
      t.string :join_code, null: false
      t.timestamps
    end
  end
end
