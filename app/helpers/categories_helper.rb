module CategoriesHelper
  COLOR_MAPPING = {
    "light-gray" => "bg-zinc-400",
    "dark-gray" => "bg-zinc-600",
    "neutral" => "bg-neutral",
    "stone" => "bg-stone-400",
    "amber" => "bg-amber-300",
    "light-orange" => "bg-orange-400",
    "dark-orange" => "bg-orange-600",
    "yellow" => "bg-yellow-600",
    "light-red" => "bg-red-300",
    "medium-red" => "bg-red-600",
    "dark-red" => "bg-red-900",
    "light-pink" => "bg-pink-300",
    "dark-pink" => "bg-pink-600",
    "rose" => "bg-rose-700",
    "light-green" => "bg-green-300",
    "dark-green" => "bg-green-600",
    "lime" => "bg-lime-400",
    "indigo" => "bg-indigo-600",
    "light-purple" => "bg-violet-400",
    "dark-purple" => "bg-purple-600",
    "fuchsia" => "bg-fuchsia-500",
    "light-blue" => "bg-teal-400",
    "sky" => "bg-sky-400",
    "dark-blue" => "bg-blue-600"
  }

  ICONS = [
    "shopping-cart",
    "home-modern",
    "credit-card",
    "currency-dollar",
    "banknotes",
    "receipt-percent",
    "heart",
    "academic-cap",
    "tennisball",
    "book-open",
    "calendar-days",
    "building-office-2",
    "briefcase",
    "gift",
    "globe-americas",
    "light-bulb",
    "device-phone-mobile",
    "shopping-bag",
    "sparkles",
    "wrench-screwdriver",
    "user-group",
    "user",
    "wifi",
    "musical-note",
    "restaurant",
    "bandage",
    "beer",
    "car-sport",
    "fast-food",
    "dice",
    "globe",
    "pricetags",
    "ticket",
    "cafe",
    "fitness",
    "help",
    "map",
    "paw",
    "shirt",
    "trending-up"
  ]

  def category_color(category)
    COLOR_MAPPING.fetch(category.color.presence || "neutral")
  end

  def category_icon(category, **)
    icon(category.icon || "help", **)
  end

  def category_gradient_class(category)
    class_names(
      "category-gradient--income" => category.income?,
      "category-gradient--expense" => category.expense?,
    )
  end

  def category_icon_placeholder(category, **args)
    tag.span(**args) do
      category.title.chars.values_at(0, -1).map(&:upcase).join
    end
  end
end
