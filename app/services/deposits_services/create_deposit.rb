module DepositsServices
  class CreateDeposit

    def initialize
      @notes_repo = BankNotesRepository.instance
      @balance_repo = BalanceRepository.instance
    end

    def execute(raw_data)
      notes = @notes_repo.bank_notes
      data = raw_data[:bank_notes].transform_keys!(&:to_i).transform_values!(&:to_i)
      check_deposit data

      notes.merge!(data){ |key, current, deposit| current + deposit }
      updated_bank_notes = @notes_repo.update(notes)
      @balance_repo.update(updated_bank_notes)

      updated_bank_notes
    end

    private

    def check_deposit data
      data.each do |key, value|
        raise StandardError unless value.to_i.positive?
        raise StandardError unless BankNotesRepository::ACCEPTED_NOTES.include?(key.to_i)
      end
    end
  end
end