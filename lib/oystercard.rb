require_relative 'fare'
require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance, :journeys
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    check_maximum_balance(amount)
    @balance += amount
  end

  def in_journey?
    return false if @journeys.empty?
    @journeys[-1].entry_station != :no_station && @journeys[-1].exit_station == :no_station
  end

  def touch_in(station)
    deduct_fare(@journeys[-1].calculate_fare) if in_journey?
    check_minimum_balance
    add_journey(station)
    self
  end

  def touch_out(station)
    add_journey(:no_station) unless in_journey?
    updates_end_journey(station)
    deduct_fare(@journeys[-1].calculate_fare)
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

  def updates_end_journey(station)
    @journeys[-1].end_journey(station)
  end

  def add_journey(station)
    @journeys << Journey.new.start_journey(station)
  end
end
