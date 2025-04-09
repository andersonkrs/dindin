class Onboarding
  class << self
    def run!
      setup_default_categories!
      setup_default_accounts!
    end

    def setup_default_categories!
      Category.expense.where(title: "Clothing").first_or_create!(icon: "shirt", color: "light-purple")
      Category.expense.where(title: "Delivery").first_or_create!(icon: "fast-food", color: "dark-orange")
      Category.expense.where(title: "Eating out").first_or_create!(icon: "restaurant", color: "rose")
      Category.expense.where(title: "Fitness").first_or_create!(icon: "fitness", color: "sky")
      Category.expense.where(title: "Groceries").first_or_create!(icon: "shopping-cart", color: "yellow")
      Category.expense.where(title: "Heath").first_or_create!(icon: "hearth", color: "medium-red")
      Category.expense.where(title: "Housing").first_or_create!(icon: "home-modern", color: "light-blue")
      Category.expense.where(title: "Leisure").first_or_create!(icon: "ticket", color: "fuchsia")
      Category.expense.where(title: "Others").first_or_create!(icon: "help", color: "dark-gray")
      Category.expense.where(title: "Pets").first_or_create!(icon: "pawn", color: "dark-green")
      Category.expense.where(title: "Subscriptions").first_or_create!(icon: "credit-card", color: "dark-blue")
      Category.expense.where(title: "Shopping").first_or_create!(icon: "pricetags", color: "indigo")
      Category.expense.where(title: "Transportation").first_or_create!(icon: "car-sport", color: "lime")
    end

    def setup_default_accounts!
      Account.first_or_create!(title: "Wallet")
    end
  end
end
