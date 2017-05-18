require_relative 'fare'
require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance, :journeys, :journey_log
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @journeys = []
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    check_maximum_balance(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct_fare(@journey_log.journeys[-1].calculate_fare) if @journey_log.started
    check_minimum_balance
    @journey_log.start(station)
    self
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct_fare(@journey_log.journeys[-1].calculate_fare)
    self
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

  def check_minimum_balance
    fail "Balance below minimum" if @balance < Fare::MIN_FARE
  end

  def check_maximum_balance(amount)
    fail "Cannot top_up above #{MAX_BALANCE}" if amount + @balance > MAX_BALANCE
  end

end
