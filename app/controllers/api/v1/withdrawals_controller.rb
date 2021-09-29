module Api
  module V1
    class WithdrawalsController < BaseController

      def create
        schema = Schemas::V1::Withdrawals::Create.new
        data = validate_request(schema: schema)
        bank_notes = WithdrawalsServices::DispenseNotes.new.execute(data[:amount])

        render json: bank_notes
      end
    end
  end
end