class JourneyLog

  attr_reader :journeys

  def initialize
    @journeys = []
  end

  def start(station)
    @journeys << Journey.new.start_journey(station)
  end

end
