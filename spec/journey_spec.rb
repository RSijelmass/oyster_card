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

  it "responds #end_journey" do
    expect(journey).to respond_to(:end_journey).with(1).argument
  end

  it "responds #calculate_fare" do
    expect(journey).to respond_to(:calculate_fare)
  end

  it "returns MIN_FARE" do
    expect(journey.calculate_fare).to eq Fare::MIN_FARE
  end

  it "returns false if journey is incomplete" do
    journey.start_journey("A")
    expect(journey.complete?).to eq false
  end

  it "returns true if journey is complete" do
    journey.start_journey("A")
    journey.end_journey("B")
    expect(journey.complete?).to eq true
  end
end
