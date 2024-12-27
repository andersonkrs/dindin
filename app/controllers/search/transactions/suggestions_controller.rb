class Search::Transactions::SuggestionsController < AccountController
  def index
    @transactions = Expense
      .where("lower(title) LIKE lower(?)", "%#{params[:q]}%")
      .order(title: :asc)
      .limit(5)
  end
end
