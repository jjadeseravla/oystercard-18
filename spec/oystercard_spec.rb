require 'oystercard'

describe Oystercard do

let(:entry_station) { double :station }
let(:exit_station) { double :station }
let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  it 'stores the entry station' do
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq station
  end

  it 'stores the exit station' do
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(station.exit_station).to eq exit_station
  end

  it 'has empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  it 'stores a journey' do
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }
  # end

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if max top up is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up max_balance
      expect{ subject.top_up 1 }.to raise_error 'max balance of #{max_balance} exceeded'
    end
  end

  describe '#touch_in' do

    # it 'can touch in' do
    #   subject.top_up(20)
    #   subject.touch_in(:station)
    #   expect(subject).to be_in_journey
    # end

    it 'raises an error if does not have the minimum fare to touch in' do
      min_balance = Oystercard::MIN_BALANCE
      expect{ subject.touch_in 1 }.to raise_error '#{min_balance} is not sufficient, you must top up'
    end
  end

  describe '#touch_out' do

    it 'can touch out' do
      subject.top_up(20)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject).not_to be_in_journey
    end

    it 'can deduct money when touch out' do
      subject.top_up(20)
      subject.touch_in(:station)
      expect{ subject.touch_out 1}.to change{ subject.balance }.by(-Oystercard::MIN_CHARGE)
    end

  end

end
