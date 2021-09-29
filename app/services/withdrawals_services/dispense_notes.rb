module WithdrawalsServices
  class DispenseNotes

    def initialize
      @notes_repo = BankNotesRepository.instance
      @balance_repo = BalanceRepository.instance
    end

    def execute(amount)
      withdrawn_notes = {}
      withdrawn_amount = 0
      notes = @notes_repo.bank_notes.keys.sort.reverse
      notes_balance = @notes_repo.bank_notes

      notes.each do |note|
        next if amount - withdrawn_amount <= 0

        max_notes_available = (amount - withdrawn_amount).divmod(note).first
        available_notes_number = [notes_balance[note], max_notes_available].min

        if available_notes_number.positive?
          withdrawn_amount += available_notes_number * note
          withdrawn_notes[note] = available_notes_number
        end
      end

      raise Error::PreconditionFailed, 'Amount cannot be withdrawn' if withdrawn_amount < amount

      update_balance notes_balance, withdrawn_notes

      withdrawn_notes
    end

    private

    def update_balance notes, withdrawn_notes
      notes.merge!(withdrawn_notes){ |key, current, withdrawal| current - withdrawal }
      updated_bank_notes = @notes_repo.update(notes)
      @balance_repo.update(updated_bank_notes)
    end
  end
end