class BankNotesRepository
  include Singleton
  ACCEPTED_NOTES = [1, 2, 5, 10, 25, 50]

  def initialize
    @bank_notes = { 1 => 0, 2 => 0, 5 => 0, 10 => 0, 25 => 0, 50 => 0 }
  end

  def bank_notes
    @bank_notes
  end

  def update bank_notes
    @bank_notes = bank_notes
    @bank_notes
  end
end