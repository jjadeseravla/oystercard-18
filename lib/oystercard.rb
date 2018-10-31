class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @touch_in = false
  end

  def top_up(amount)
    fail 'max balance of #{max_balance} exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @touch_in
  end

  def touch_in
    @touch_in = true
  end

  def touch_out
    @touch_in = false
  end

end
