require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  before(:each) {stub_const("FakeFare::MIN_FARE", 1)}
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

    it 'sets entry_station to the current station when a card is touched in' do
      oystercard.top_up(FakeFare::MIN_FARE)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    before(:each) do
      oystercard.top_up(FakeFare::MIN_FARE)
      oystercard.touch_in(station)
    end

    it 'reduces the balance by the minimum fare on touch out' do
      expect{oystercard.touch_out(station)}.to change { oystercard.balance }.by -1
    end

    it 'sets entry_station to nil when card is touched out' do
      oystercard.touch_out(station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'records the last journey in the @journeys hash' do
      oystercard.touch_out(station2)
      expect(oystercard.journeys[:journey1]).to eq [station, station2]
    end
  end

end
