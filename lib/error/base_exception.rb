module Error
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :meta, :code

    def initialize(message = 'Internal server error',
                   status: :internal_server_error)

      super(message)
      @status = status
    end

    # returns the error as its hash representation
    def to_hash
      {
        message: message,
        status: status
      }.compact
    end
    alias_method 'to_h', 'to_hash'

    def status
      Rack::Utils.status_code(@status)
    rescue NameError
      StatusCodes.status_code(@status)
    end
  end
end