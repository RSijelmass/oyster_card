
require_relative 'station'
require_relative 'journey_log'

# This maintains a balance and acts as an interface to other Class objects
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
    raise 'Balance below minimum' if @balance < MIN_BALANCE
  end

  def check_maximum_balance(amount)
    raise "Can't top_up above #{MAX_BALANCE}" if amount + @balance > MAX_BALANCE
  end
end
