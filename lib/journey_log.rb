class JourneyLog

  attr_reader :journeys, :started

  def initialize
    @journeys = []
    @started = false
  end

  def start(station)
    @journeys << Journey.new.start_journey(station)
    @started = true
  end

  def finish(station)
    start(:no_station) unless @started
    @journeys[-1].end_journey(station)
    @started = false
  end

end
