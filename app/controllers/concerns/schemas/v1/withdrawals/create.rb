module Schemas
  module V1
    module Withdrawals
      class Create < Dry::Validation::Contract
        schema do
          required(:amount).filled(Types::Params::Integer, gt?: 0)
        end
      end
    end
  end
end