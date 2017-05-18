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

  describe '#in_journey?' do

    it "initializes oystercards with an empty journeys array" do
      expect(oystercard).not_to be_in_journey
    end

    it "shows the oystercard as in_journey after touch_in" do
      oystercard.top_up(FakeFare::MIN_FARE)
      station = Station.new("Liverpool Street",1)
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it "shows the oystercard as !in_journey after touch_out" do
      oystercard.top_up(FakeFare::MIN_FARE)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard).not_to be_in_journey
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
      expect(oystercard.journeys[-1].entry_station).to eq station
    end

    it 'forgetting to touch out, #touch_in creates a new journey' do
      oystercard.top_up(described_class::MAX_BALANCE)
      oystercard.touch_in(station)
      oystercard.touch_in(station2)
      expect(oystercard.journeys.length).to eq 2
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

    it 'updates journeys with correct exit_station when card is touched out' do
      oystercard.top_up(FakeFare::MIN_FARE)
      station1 = Station.new("Liverpool Street",1)
      oystercard.touch_in(station1)
      station2 = Station.new("Acton",4)
      oystercard.touch_out(station2)
      expect(oystercard.journeys[-1].exit_station).to eq station2
    end

    it "forgetting to touch in, #touch_out creates a new journey" do
      oystercard.touch_out(station)
      expect(oystercard.journeys).not_to be_empty
    end

  end

end
