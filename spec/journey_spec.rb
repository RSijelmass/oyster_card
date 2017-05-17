require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  it "has an entry_station" do
    journey1 = Journey.new("Brixton")
    expect(journey1.entry_station).to eq "Brixton"
  end

  it "has an exit_station" do
    journey1 = Journey.new("Brixton","Liverpool Street")
    expect(journey1.exit_station).to eq "Liverpool Street"
  end

  it "responds #start_journey" do
    expect(journey).to respond_to(:start_journey).with(1).argument
  end

end
