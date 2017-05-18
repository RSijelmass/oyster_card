require 'journey_log'

describe JourneyLog do
  subject(:journeylog) { described_class.new }
  let(:journey) { double(:journey, start_journey: true) }
  let(:station) { double(:station) }
  describe '#start' do

    it 'starts a new journey' do
      expect{journeylog.start(station)}.to change{ journeylog.journeys.length }.by 1
    end

  end

end
