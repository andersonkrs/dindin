module TransactionsHelper
  def transactions_date_divider(date)
    tag.div class: "hide-duplicate-divider mx-1 py-2 flex items-center text-sm font-semibold text-gray-500", data: { sort_key: date.to_fs(:number) } do
      I18n.l(date, format: :long)
    end
  end
end
