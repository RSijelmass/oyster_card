require_relative 'journey'

class JourneyLog

  attr_reader :journeys, :started

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new.start_journey(station)
    @journeys << @current_journey
  end

  def finish(station)
    current_journey
    @current_journey.end_journey(station)

  end

  def calculate_fare
    @current_journey.complete? ? Journey::MIN_FARE : Journey::PENALTY_FARE
  end

  def current_journey
    @current_journey ||= @journey_class.new
  end

end
