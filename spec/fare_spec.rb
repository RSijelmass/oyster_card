require 'fare'

describe Fare do
  it 'should contain a constant for MIN_FARE' do
    expect(Fare::MIN_FARE).to respond_to(:to_f)
  end
end
