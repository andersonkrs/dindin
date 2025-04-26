class Transaction < ApplicationRecord
  include Recurring
  include Broadcasting

  belongs_to :category
  belongs_to :account
  belongs_to :creator, default: -> { Current.user }, class_name: "User"

  attribute :due_on, :date, default: -> { Date.current }
  attribute :paid_at, :date, default: -> { Date.current }

  monetize :value_cents

  validates :title, presence: true

  scope :most_recent_sorted, -> { order(created_at: :desc, id: :desc) }

  def month
    Month.from_date(due_on)
  end

  def paid? = paid_at.present?
  def unpaid? = paid_at.blank?

  def overdue? = unpaid? && due_on < Date.current
  def due_today? = unpaid? && due_on == Date.current
  def almost_due? = unpaid? && !overdue? && due_on - Date.current <= 3

  def sort_key
    "#{due_on.to_fs(:number)}#{id}"
  end

  def divider_key
    due_on.to_fs(:number)
  end
end
