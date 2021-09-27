module Api
  module V1
    class DepositsController < BaseController

      def create
        schema = Schemas::V1::Deposits::Create.new
        data = validate_request(schema: schema)
        bank_notes = DepositsServices::CreateDeposit.new.execute(data)

        render json: bank_notes
      end
    end
  end
end