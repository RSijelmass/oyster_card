require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  it "has an entry_station" do
    journey1 = Journey.new("Brixton")
    expect(journey1.entry_station).to eq "Brixton"
  end


end
