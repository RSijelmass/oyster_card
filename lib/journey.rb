class Journey
  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start_journey(station)
    @entry_station = station
    self
  end

  def end_journey(station)
    @exit_station = station
    self
  end

  def complete?
    @entry_station != :no_station && @exit_station != :no_station
  end

end
