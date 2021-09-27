module Schemas
  module V1
    module Deposits
      class Create < Dry::Validation::Contract
        schema do
          required(:bank_notes).filled
        end
      end
    end
  end
end