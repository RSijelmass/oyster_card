require_relative 'station'
require_relative 'journey_log'

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
    # deduct_fare() TODO: decide how to gather fare information
    check_minimum_balance
    @journey_log.start(station)
    self
  end

  def touch_out(station)
    @journey_log.finish(station)
    # deduct_fare() TODO: decide how to gather fare information
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
card.touch_in('A')
card.touch_out('B')
puts card.balance
log = card.journey_log
p log.journeys

card.touch_in'C'
card.touch_out'D'

card.touch_out'E'

p log.journeys