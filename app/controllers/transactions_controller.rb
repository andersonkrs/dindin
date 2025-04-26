class TransactionsController < AccountController
  before_action :set_month, only: %i[ index ]
  before_action :set_transaction, only: %i[ destroy ]

  def index
    set_page_and_extract_portion_from @month.transactions, ordered_by: { due_on: :desc, id: :desc }

    @categories = Category.where(id: @page.records.select(:category_id))
  end

  def destroy
    @transaction.destroy!
    flash.now[:notice] = "#{@transaction.model_name.human} destroyed"
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_month
    @month = Month.parse(params[:month]) || Month.current
  end
end
