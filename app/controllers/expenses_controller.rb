class ExpensesController < AccountController
  before_action :set_transaction, only: %i[ edit update ]

  def new
    @transaction = Expense.new

    render "transactions/new"
  end

  def create
    @transaction = Expense.new(expense_params)

    respond_to do |format|
      if @transaction.save
        flash.now[:notice] = "Expense created"
        format.turbo_stream
      else
        format.html { render "transactions/new", status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(expense_params)
        flash.now[:notice] = "Expense updated"
        format.turbo_stream
      else
        format.html { render "transactions/edit", status: :unprocessable_entity }
      end
    end
  end

  def edit
    render "transactions/edit"
  end

  private

  def set_transaction
    @transaction = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    paid_at = params[:expense][:paid] == "1" ? Time.zone.today : nil

    params
      .require(:expense)
      .permit(
        :title,
        :due_on,
        :value,
        :category_id,
        :account_id,
      ).with_defaults(
        paid_at: paid_at,
      )
  end
end
