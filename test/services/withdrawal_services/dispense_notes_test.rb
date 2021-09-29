require 'test_helper'

module WithdrawalServices
  class DispenseNotesTest < ActiveSupport::TestCase
    test 'dispenses correct notes' do
      # Given
      initial_deposit = DepositsServices::CreateDeposit.new
                                                       .execute(1 => 10, 5 => 7, 10 => 9, 50 => 3)
      initial_balance = BalanceRepository.instance.balance
      required_amount = 85
      expected_notes = { 50 => 1, 10 => 3, 5 => 1 }

      # When
      notes = WithdrawalsServices::DispenseNotes.new.execute(required_amount)

      # Then
      assert_equal expected_notes, notes
      assert BalanceRepository.instance.balance < initial_balance
    end

    test 'raises PreconditionFailed when not enough money' do
      # Given
      initial_deposit = DepositsServices::CreateDeposit.new
                                                       .execute(1 => 10)
      required_amount = 85

      # When / Then
      assert_raises(Error::PreconditionFailed) do
        WithdrawalsServices::DispenseNotes.new.execute(required_amount)
      end
    end
  end
end
