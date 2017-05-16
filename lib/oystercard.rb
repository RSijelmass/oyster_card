class Oystercard

  attr_reader :balance
  Maximum_balance = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Cannot top_up above #{Maximum_balance}" if amount + @balance > Maximum_balance
    @balance += amount
  end

  def deduct_fare(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    # raise "Balance below minimum" if @balance <= fare.minimum_fare
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
