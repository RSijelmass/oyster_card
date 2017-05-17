class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = :no_station, exit_station = :no_station)
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

  def calculate_fare
    Fare::MIN_FARE
  end

end
