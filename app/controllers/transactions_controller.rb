class TransactionsController < AccountController
  before_action :set_transaction, only: %i[ destroy ]

  def index
    set_page_and_extract_portion_from Transaction.all, ordered_by: { due_on: :desc, id: :desc }

    fresh_when(@page.records)
  end

  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "#{@transaction.model_name.human} was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
