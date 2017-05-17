require_relative 'fare'
require_relative 'station'

class Oystercard

  attr_reader :balance, :entry_station, :journeys
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = Hash.new
  end

  def top_up(amount)
    fail "Cannot top_up above #{MAX_BALANCE}" if amount + @balance > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail "Balance below minimum" if @balance < Fare::MIN_FARE
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct_fare(Fare::MIN_FARE)
    record_journey(entry_station, exit_station)
    @entry_station = nil
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

  def record_journey(station1, station2)
    @journeys["journey#{journeys.length+1}".to_sym] = [station1, station2]
  end

end
