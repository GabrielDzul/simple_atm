module SchemaValidable
  #
  # Validates request data against an schema
  #
  # @param [Hash] request_data data to validate
  # @param [Dry::Validation::Contract] schema validation schema
  #
  # @return [Hash]
  #
  # @raise [Error::UnprocessableEntity]
  #
  def validate_request(request_data: get_inferred_params, schema:)
    validated_params = schema.call(request_data)

    if validated_params.failure?
      raise StandardError
    end

    validated_params.to_h
  end

  private

  def get_inferred_params
    params.permit!.to_h
  end
end