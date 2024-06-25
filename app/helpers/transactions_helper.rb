module TransactionsHelper
  def edit_path(transaction)
    case transaction.type
    in "Expense"
      edit_expense_path(transaction)
    end
  end
end
