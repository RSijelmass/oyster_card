require 'journey_log'

describe JourneyLog do

  let(:journey) { double(:journey, start_journey: nil) }
  let(:journey_class) { double(:class, new: journey) }

  subject(:journeylog) { described_class.new(journey_class) }

  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

  describe '#start' do
    it 'starts a new journey' do
      expect{journeylog.start(station)}.to change{ journeylog.journeys.length }.by 1
    end

    end

end
