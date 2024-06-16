class TransactionsController < AccountController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  def index
    @transactions = Transaction.order(due_on: :desc, id: :desc)
  end

  def show
  end

  def new
    @transaction = Transaction.new(paid_at: Time.zone.today)
  end

  def edit
  end

  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to new_transaction_url, notice: "Transaction successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transactions_url, notice: "Transaction successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      paid_at = params[:transaction][:paid] == "1" ? Time.zone.today : nil

      params.require(:transaction).permit(
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
