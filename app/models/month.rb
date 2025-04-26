class Month
  include Comparable

  attr_reader :year, :month

  def self.current
    today = Date.current
    new(today.year, today.month)
  end

  def self.from_date(date)
    self.new(date.year, date.month)
  end

  def self.parse(param)
    return nil if param.blank?

    match = param.match(/(\d{4})-(\d{2})/)
    return nil unless match

    new(match[1].to_i, match[2].to_i)
  end

  def initialize(year, month)
    @year = year
    @month = month

    @date = Date.new(year, month, 1)
  end

  def current?
    self == Month.current
  end

  def current_year?
    year == Date.current.year
  end

  def to_param
    "#{year}-#{month.to_s.rjust(2, '0')}"
  end

  def to_turbo_steam
    "month_#{@date.strftime('%Y_%m')}"
  end

  def to_s
    @date.strftime("%B %Y")
  end

  def previous
    prev_date = @date.prev_month
    self.class.new(prev_date.year, prev_date.month)
  end

  def next
    next_date = @date.next_month
    self.class.new(next_date.year, next_date.month)
  end

  def start_date
    @date.beginning_of_month
  end

  def end_date
    @date.end_of_month
  end

  def <=>(other)
    return nil unless other.is_a?(Month)

    [year, month] <=> [other.year, other.month]
  end

  def transactions
    Transaction.where(due_on: start_date..end_date)
  end
end
