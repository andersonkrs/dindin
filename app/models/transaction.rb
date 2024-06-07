class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :account

  monetize :value_cents

  attribute :value_cents, :integer, default: -> { nil }
  attribute :due_on, :date, default: -> { Date.today }
  attribute :paid_at, :date, default: -> { Date.today }
end
