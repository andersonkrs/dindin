module Transaction::Broadcasting
  extend ActiveSupport::Concern

  included do
    after_create_commit :broadcast_prepend_to_current_month

    after_update_commit -> {
      if saved_change_to_due_on?
        broadcast_remove_from_previous_month
        broadcast_prepend_to_current_month
      else
        broadcast_replace_to_current_month
      end
    }

    after_destroy_commit -> {
      broadcast_remove_to [:transactions, month], target: self
    }
  end

  private

  def broadcast_prepend_to_current_month
    broadcast_prepend_later_to(
      [:transactions, month],
      target: :transactions,
      partial: "transactions/transaction",
      locals: { transaction: self },
    )
  end

  def broadcast_remove_from_previous_month
    broadcast_remove_to [:transactions, Month.from_date(due_on_before_last_save)], target: self
  end

  def broadcast_replace_to_current_month
    broadcast_replace_later_to(
      [:transactions, month],
      target: self,
      partial: "transactions/transaction",
      locals: { transaction: self },
    )
  end
end
