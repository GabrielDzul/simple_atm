module Error
  class PreconditionFailed < BaseException
    def initialize(message = nil)
      super message || 'Precondition failed',
            status: :precondition_failed
    end
  end
end