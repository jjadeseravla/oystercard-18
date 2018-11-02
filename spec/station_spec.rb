require 'station'
require 'oystercard'

describe Station do

  subject {described_class.new(name: "Bank", zone: 1)}

  it 'knows its name' do
    expect(subject.name).to eq("Bank")
  end

  it 'knows the zone of the station' do
    expect(subject.zone).to eq(1)
  end

end
