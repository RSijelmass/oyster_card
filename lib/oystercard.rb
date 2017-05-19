require_relative 'station'
require_relative 'journey_log'

# Oystercard Class info...

# Behaviour:
# - touch_in
# - touch_out
# - top_up
# - deduct

# State
# - Balance
# - JourneyLog
# - Minimum balance constant
# - Maximum balance constant
class Oystercard

  attr_reader :balance, :journey_log

  MIN_BALANCE = 1
  MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    check_maximum_balance(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct_fare(@journey_log.calculate_fare) if @journey_log.started
    check_minimum_balance
    @journey_log.start(station)
    self
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct_fare(@journey_log.calculate_fare)
    self
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

  def check_minimum_balance
    fail "Balance below minimum" if @balance < MIN_BALANCE
  end

  def check_maximum_balance(amount)
    fail "Cannot top_up above #{MAX_BALANCE}" if amount + @balance > MAX_BALANCE
  end

end

card = Oystercard.new(20)

puts card.balance
card.touch_in('A')
puts card.balance
card.touch_out('B')
puts card.balance
print card.journey_log.journeys