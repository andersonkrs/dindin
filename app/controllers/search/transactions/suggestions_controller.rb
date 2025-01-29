class Search::Transactions::SuggestionsController < AccountController
  def index
    subquery = Expense
      .where("lower(title) LIKE lower(?)", "%#{URI.decode_www_form_component(params[:q])}%")
      .select("transactions.*, ROW_NUMBER() OVER(PARTITION BY title ORDER BY transactions.id DESC) AS row_no")

    @transactions = Transaction
      .with(transactions_by_uniq_title: subquery)
      .from("transactions_by_uniq_title AS transactions")
      .includes(:category, :account)
      .where(row_no: 1)
      .most_recent_sorted
      .limit(2)

    head :no_content and return if @transactions.empty?
  end
end
