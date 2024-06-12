class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :account
  belongs_to :creator, default: -> { Current.user }, class_name: "User"

  monetize :value_cents

  attribute :due_on, :date, default: -> { Date.today }
  attribute :paid_at, :date, default: -> { Date.today }
end
