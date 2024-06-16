class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :account
  belongs_to :creator, default: -> { Current.user }, class_name: "User"

  attribute :due_on, :date, default: -> { Time.zone.today }
  attribute :paid_at, :date, default: -> { Time.zone.today }

  monetize :value_cents

  def paid? = paid_at.present?
end
