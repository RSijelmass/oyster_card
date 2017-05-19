
require_relative 'journey'

# This records journeys and allows indirect interaction between an OysterCard
# and a Journey
class JourneyLog
  attr_reader :started

  def initialize(journey_class)
    @journey_class = journey_class
    @journey_history = []
    @journey = nil
    @started = false
  end

  def start(station)
    @journey = @journey_class.new.start_journey(station)
    @journey_history << @journey
    @started = true
  end

  def finish(station)
    start(nil) unless @started
    @journey.end_journey(station)
    @started = false
  end

  def calculate_fare
    return Journey::PENALTY_FARE unless @journey.complete?
    Journey::MIN_FARE + distance_travelled
  end

  def journeys
    @journey_history.dup
  end

  private

  def distance_travelled
    (@journey.entry_station.zone - @journey.exit_station.zone).abs
  end
end
