module DefaultHandling
  def self.included(cls)
    cls.class_eval do

      # must go first in order to preserve last priority
      # https://stackoverflow.com/a/9121054/3287738
      rescue_from Error::BaseException do |e|
        respond e
      end
    end
  end

  def respond(error)
    render json: error,
           status: error.status,
           serializer: APIErrorSerializer,
           adapter: :json,
           root: 'error'
  end
end
