class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 5
  MIN_CHARGE = 2

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail 'max balance of #{max_balance} exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
    # @entry_station != nil
  end

  def touch_in(entry_station)
    fail '#{min_balance} is not sufficient, you must top up' if balance < MIN_CHARGE
    @in_journey = true
  end

  def touch_out(exit_station)
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
