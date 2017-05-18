require 'journey_log'

describe JourneyLog do
  subject(:journeylog) { described_class.new }
  let(:journey) { double(:journey) }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

  describe '#start' do
    it 'starts a new journey' do
      expect{journeylog.start(station)}.to change{ journeylog.journeys.length }.by 1
    end

    it 'changes @started to true' do
      expect{journeylog.start(station)}.to change{journeylog.started}.to true
    end
  end

  describe '#finish' do
    it 'finishes a current journey' do
      # not using proper doubles
      journeylog.start(station)
      journeylog.finish(station2)
      expect(journeylog.journeys[-1].exit_station).to eq station2
    end

    it 'creates a new journey in case we only touch out' do
      expect{journeylog.finish(station)}.to change{ journeylog.journeys.length }.by 1
    end

    it 'changes @started to false' do
      journeylog.start(station)
      expect{journeylog.finish(station)}.to change{journeylog.started}.to false
    end
  end

end
