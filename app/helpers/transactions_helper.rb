module TransactionsHelper
  def transactions_load_more(**)
    return if @page.last?

    turbo_frame_tag dom_id(Transaction, :load_more), src: transactions_path(page: @page.next_param, format: :turbo_stream), loading: :lazy
  end

  def transactions_date_divider(date)
    tag.div class: "mx-1 py-2 flex items-center text-sm font-semibold text-gray-500" do
      I18n.l(date, format: :long)
    end
  end
end
