# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.where(email: "admin@example.com").first_or_create!(password: "password")

["Wallet" "Santander Master Card"].each do |account_name|
  Account.where(title: account_name).first_or_create!
end

Category.income.where(title: "Job Revenue").first_or_create!

Category.expense.where(title: "Pets").first_or_create!
Category.expense.where(title: "Dinning Out").first_or_create!
Category.expense.where(title: "Groceries").first_or_create!
Category.expense.where(title: "Gas").first_or_create!
Category.expense.where(title: "Others").first_or_create!
