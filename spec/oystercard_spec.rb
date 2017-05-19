require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  before(:each) { stub_const("FakeFare::MIN_FARE", 1) }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

  describe '#balance' do
    it "returns a value for the balance" do
      expect(oystercard.balance).to eq 0
    end

    it "Increases the balance when top_up is called" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it "errors if a maximum balance is reached" do
      expect{ oystercard.top_up(91) }.to raise_error "Cannot top_up above #{oystercard.class::MAX_BALANCE}"
    end

  end

  describe '#touch_in' do
    it 'should raise an error if the card is touched in without meeting the minimum balance' do
      expect{oystercard.touch_in(station)}.to raise_error "Balance below minimum"
    end

    it 'saves journey with correct entry_station in @journeys when a card is touched in' do
      oystercard.top_up(FakeFare::MIN_FARE)
      station = Station.new("Liverpool Street",1)
      oystercard.touch_in(station)
      expect(oystercard.journey_log.journeys[-1].entry_station).to eq station
    end

    it 'forgetting to touch out, #touch_in creates a new journey' do
      oystercard.top_up(described_class::MAX_BALANCE)
      oystercard.touch_in(station)
      oystercard.touch_in(station2)
      expect(oystercard.journey_log.journeys.length).to eq 2
    end

    it 'deducts penalty fare if forgot to #touch_out' do
      oystercard.top_up(described_class::MAX_BALANCE)
      oystercard.touch_in(station)
      expect{ oystercard.touch_in(station2) }.to change { oystercard.balance }.by -6
    end
  end

  describe '#touch_out' do
    before(:each) do
      oystercard.top_up(FakeFare::MIN_FARE)
    end

    it 'reduces the balance by the minimum fare on touch out' do
      oystercard.touch_in(station2)
      expect{oystercard.touch_out(station)}.to change { oystercard.balance }.by -1
    end

  end

end
