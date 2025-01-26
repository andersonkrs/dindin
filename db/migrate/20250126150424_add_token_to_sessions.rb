class AddTokenToSessions < ActiveRecord::Migration[8.0]
  def change
    change_table :sessions, bulk: true do |t|
      t.string :token, null: true
      t.index :token, unique: true
    end
  end
end
