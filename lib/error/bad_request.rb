module Error
  class BadRequest < BaseException
    def initialize(message = nil)
      super message || 'Bad request',
            status: :bad_request
    end
  end
end