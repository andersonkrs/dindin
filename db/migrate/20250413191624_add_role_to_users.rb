class AddRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string, default: "member", null: false

    add_check_constraint :users, "role IN ('admin', 'member')", name: :users_role_check
  end
end
