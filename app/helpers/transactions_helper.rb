module TransactionsHelper
  def transaction_title_autocomplete(form, field)
    render partial: "transactions/suggestion_autocomplete", locals: { form: form, field: field }
  end

  def transactions_formatted_month(month)
    if month.current_year?
      I18n.l(month.start_date, format: :month_only)
    else
      I18n.l(month.start_date, format: :month_year)
    end
  end
end
