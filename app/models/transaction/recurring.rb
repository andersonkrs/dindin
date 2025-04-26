module Transaction::Recurring
  extend ActiveSupport::Concern

  FUTURE_TRANSACTIONS_LIMIT = 5.years

  included do
    belongs_to :recurrence, optional: true

    accepts_nested_attributes_for :recurrence

    before_validation :set_recurrence_attributes, on: :create
    before_commit :create_recurrent_transactions, on: :create, if: -> { recurrence.present? }
    before_commit :destroy_future_transactions, on: :destroy, if: -> { recurrence.present? }
  end

  def recurrent? = recurrence_id.present?

  private

  def set_recurrence_attributes
    self.recurrence&.start_on ||= due_on
    self.recurrence&.title ||= title
  end

  def create_recurrent_transactions
    recurrence.schedule.occurrences(FUTURE_TRANSACTIONS_LIMIT.from_now).each do |at|
      next if at.to_date <= due_on

      transaction = recurrence.transactions.find_or_initialize_by(type: type, due_on: at.to_date)
      transaction.assign_attributes(
        title: title,
        category: category,
        account: account,
        value: value,
        paid_at: paid? ? at.to_date : nil,
      )
      transaction.save!(validate: false)
    end
  end

  def destroy_future_transactions
    recurrence.transactions.where.not(id: id).where("due_on >= ?", due_on).destroy_all
  end
end
