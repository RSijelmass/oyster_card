require 'station'

describe Station do

  subject(:station) { described_class.new(:name, :zone) }

    it { is_expected.to respond_to(:name) }

    it { is_expected.to respond_to(:zone) }

    it "calls station.name" do
      expect(station.name).to eq :name
    end

    it "calls station.zone" do
      expect(station.zone).to eq :zone
    end

end
