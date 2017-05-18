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
    complete? ? Fare::MIN_FARE : Fare::PENALTY_FARE
  end

  private

  def complete?
    @entry_station != :no_station && @exit_station != :no_station
  end

end
