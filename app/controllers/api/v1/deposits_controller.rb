module Api
  module V1
    class DepositsController < BaseController

      def create
        schema = Schemas::V1::Deposits::Create.new
        data = validate_request(schema: schema)
        transformed_data = data[:bank_notes].transform_keys!(&:to_i).transform_values!(&:to_i)
        bank_notes = DepositsServices::CreateDeposit.new.execute(transformed_data)

        render json: bank_notes
      end
    end
  end
end