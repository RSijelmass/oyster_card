require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it "returns a value for the balance" do
      expect(oystercard.balance).to eq 0
    end

    it "Increases the balance when top_up is called" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it "errors if a maximum balance is reached" do
      expect{ oystercard.top_up(91) }.to raise_error "Cannot top_up above #{oystercard.class::Maximum_balance}"
    end

    it "Decreases the balance when deduct_fare is called" do
      expect{oystercard.deduct_fare(10)}.to change{ oystercard.balance }.by -10
    end
  end

  describe '#in_journey?' do
    it "initializes oystercards with a default value of 'ready_to_use'" do
      expect(oystercard).not_to be_in_journey
    end

    it "shows the oystercard as in_journey after touch_in" do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it "shows the oystercard as !in_journey after touch_out" do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end

  # describe '#touch_in' do
  #   it 'should raise an error if the card is touched in without meeting the minimum balance' do
  #     expect{oystercard.touch_in}.to raise_error "Balance below minimum"
  #   end
  # end
end
