require_relative 'journey'

class JourneyLog

  attr_reader :started

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
    @started = false
  end

  def start(station)
    @current_journey = @journey_class.new.start_journey(station)
    @journeys << @current_journey
    @started = true
  end

  def finish(station)
    start(nil) unless @started
    @current_journey.end_journey(station)
    @started = false
  end

  def calculate_fare
    @current_journey.complete? ? Journey::MIN_FARE : Journey::PENALTY_FARE
  end

  def journeys
    @journeys.dup
  end

end
