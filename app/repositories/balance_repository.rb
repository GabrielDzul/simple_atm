class BalanceRepository
  include Singleton

  def initialize
    @balance = 0
  end

  def balance
    @balance
  end

  def update bank_notes
    @balance = bank_notes.map{ |bank_note, quantity| bank_note * quantity }.reduce(:+)
  end
end