require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  it 'has an entry_station' do
    journey1 = Journey.new('Brixton')
    expect(journey1.entry_station).to eq 'Brixton'
  end

  it 'has an exit_station' do
    journey1 = Journey.new('Brixton','Liverpool Street')
    expect(journey1.exit_station).to eq 'Liverpool Street'
  end

  it 'knows when it has been completed' do
    journey.start_journey('a')
    journey.end_journey('b')
    expect(journey).to be_complete
  end

  it 'knows when it hasn\'t been completed' do
    journey.start_journey('c')
    expect(journey).to_not be_complete
  end

end
