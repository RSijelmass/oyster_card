require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new(20) }
  # before(:each) { stub_const("FakeFare::MIN_FARE", 1) }
  let(:station_a) { double(:station, name: 'a', zone: 1) }
  let(:station_b) { double(:station, name: 'b', zone: 2) }
  let(:station_c) { double(:station, name: 'c', zone: 3) }
  let(:station_d) { double(:station, name: 'd', zone: 4) }
  let(:penalty_fare) { 6 }

  describe '#balance' do
    it 'returns a value for the balance' do
      expect(Oystercard.new.balance).to be_zero
    end

    it 'Increases the balance when top_up is called' do
      top_up_amount = 10
      expect { oystercard.top_up(top_up_amount) }.to change { oystercard.balance }.by(top_up_amount)
    end

    it 'errors if a maximum balance is reached' do
      expect{ oystercard.top_up(Oystercard::MAX_BALANCE) }.to raise_error "Can't top_up above #{Oystercard::MAX_BALANCE}"
    end
  end

  describe '#touch_in' do
    it 'should raise an error if the card is touched in without meeting the minimum balance' do
      expect { Oystercard.new.touch_in(station_a) }.to raise_error 'Balance below minimum'
    end

    it 'deducts penalty fare if forgot to #touch_out' do
      oystercard.touch_in(station_a)
      expect{ oystercard.touch_in(station_b) }.to change { oystercard.balance }.by(-penalty_fare)
    end
  end

  describe '#touch_out' do
    it 'reduces the balance the journey fare on touch out' do
      single_zone_fare = 1
      oystercard.touch_in(station_a)
      expect { oystercard.touch_out(station_a) }.to change { oystercard.balance }.by(-single_zone_fare)
    end
  end
end
