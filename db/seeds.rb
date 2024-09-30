# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

User.where(email: "admin@example.com").first_or_create!(password: "password")

["Wallet", "Santander Master Card"].each do |account_name|
  Account.where(title: account_name).first_or_create!
end

colors = CategoriesHelper::COLOR_MAPPING.keys

Category.income.where(title: "Salary").first_or_create!(color: colors.sample, icon: "currency-dollar")
Category.expense.where(title: "Dinning Out").first_or_create!(color: colors.sample, icon: "restaurant")
Category.expense.where(title: "Pets").first_or_create!(color: colors.sample, icon: "paw")
Category.expense.where(title: "Groceries").first_or_create!(color: colors.sample, icon: "shopping-cart")
Category.expense.where(title: "Gas").first_or_create!(color: colors.sample, icon: "car-sport")
Category.expense.where(title: "Clothing").first_or_create!(color: colors.sample, icon: "shirt")
Category.expense.where(title: "Leisure").first_or_create!(color: colors.sample, icon: "ticket")
Category.expense.where(title: "Sports").first_or_create!(color: colors.sample, icon: "tennisball")
Category.expense.where(title: "Shopping").first_or_create!(color: colors.sample, icon: "pricetags")
Category.expense.where(title: "Booze").first_or_create!(color: colors.sample, icon: "beer")
Category.expense.where(title: "Gifts").first_or_create!(color: colors.sample, icon: "gift")
Category.expense.where(title: "Others").first_or_create!(color: colors.sample, icon: "help")
Category.expense.where(title: "Home").first_or_create!(color: colors.sample, icon: "home-modern")
Category.expense.where(title: "Pharmacy").first_or_create!(color: colors.sample, icon: "bandage")

(2.months.ago.to_date...Date.today).each do |day|
  rand(0..5).times do
    category = Category.expense.sample
    Expense.create!({
      title: Faker::Lorem.sentence(word_count: rand(1..3)),
      category: category,
      value: [rand(1..10), rand(20..100), rand(100..500), rand(500..1200)].sample,
      account: Account.all.sample,
      due_on: day,
      creator: User.last
    })
  end
end
