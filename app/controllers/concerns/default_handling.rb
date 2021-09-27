module DefaultHandling
  def self.included(cls)
    cls.class_eval do
      include ErrorNotifier

      # must go first in order to preserve last priority
      # https://stackoverflow.com/a/9121054/3287738
      rescue_from StandardError do |e|
        report_error(e, notify: true)
      end
    end
  end

  def respond(error)
    render json: error,
           status: error.status,
           adapter: :json,
           root: 'error'
  end
end
