module TransactionsHelper
  def transaction_divider_key(transaction)
    transaction.due_on.to_fs(:number)
  end

  def transaction_divider_content(transaction)
    fmt_due_date = I18n.l(transaction.due_on, format: :long)

    return "Today, #{fmt_due_date}" if transaction.due_on == Time.zone.today
    return "Yesterday, #{fmt_due_date}" if transaction.due_on == Time.zone.yesterday
    return "#{transaction.due_on.strftime("%A")}, #{fmt_due_date}" if transaction.due_on >= 5.days.ago

    fmt_due_date
  end

  def transaction_title_autocomplete(form, field)
    render partial: "transactions/suggestion_autocomplete", locals: { form: form, field: field }
  end

  def transaction_category_combobox(form, field, collection:)
    render(
      partial: "transactions/category_combobox",
      locals: { form: form, field: field, collection: collection }
    )
  end

  def transaction_account_combobox(form, field, collection:)
    render(
      partial: "transactions/account_combobox",
      locals: { form: form, field: field, collection: collection }
    )
  end
end
