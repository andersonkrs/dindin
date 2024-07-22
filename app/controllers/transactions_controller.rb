class TransactionsController < AccountController
  before_action :set_transaction, only: %i[ destroy ]

  def index
    set_page_and_extract_portion_from Transaction.all, ordered_by: { due_on: :desc, id: :desc }
  end

  def destroy
    @transaction.destroy!
    flash.now[:notice] = "#{@transaction.model_name.human} destroyed"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
