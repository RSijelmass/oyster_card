require 'station'

describe Station do

  subject(:station) { described_class.new(:name, :zone) }

    it { is_expected.to respond_to(:name) }

    it { is_expected.to respond_to(:zone) }

    it "calls station.name" do
      expect(!!station.name).to eq true
    end

end
