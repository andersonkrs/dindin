class Recurrence < ApplicationRecord
  validates :frequency, inclusion: { in: %w[monthly yearly], message: "is invalid" }

  has_many :transactions, inverse_of: :recurrence, dependent: :nullify

  def rule
    IceCube::Rule.send(frequency).count(count)
  end

  def schedule
    IceCube::Schedule.new(start_on.in_time_zone.midnight).tap do |schedule|
      schedule.add_recurrence_rule(rule)
    end
  end
end
