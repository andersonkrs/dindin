class Search::Transactions::SuggestionsController < AccountController
  def index
    subquery = Expense
      .where("lower(title) LIKE lower(?)", "%#{params[:q]}%")
      .select("transactions.*, ROW_NUMBER() OVER(PARTITION BY title ORDER BY transactions.created_at DESC) AS row_no")

    @transactions = Transaction
      .with(transactions_by_uniq_title: subquery)
      .from("transactions_by_uniq_title AS transactions")
      .includes(:category, :account)
      .where(row_no: 1)
      .order(title: :asc)
      .limit(3)

    head :no_content and return if @transactions.empty?
  end
end
