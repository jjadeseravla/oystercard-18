require 'oystercard'

describe Oystercard do
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

  describe '#deduct' do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct money to balance' do
      subject.top_up(20)
      expect{ subject.deduct 5}.to change{ subject.balance }.by -5
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do

    it 'can touch in' do
      subject.top_up(20)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'raises an error if does not have the minimum fare to touch in' do
      min_balance = Oystercard::MIN_BALANCE
      expect{ subject.touch_in }.to raise_error '#{min_balance} is not sufficient, you must top up'
    end
  end

  it 'can touch out' do
    subject.top_up(20)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end
