module Api
  module V1
    class BaseController < ActionController::API
      include DefaultHandling
      include SchemaValidable

      before_action :underscore_params!

      def underscore_params!
        params.deep_transform_keys!(&:underscore)
      end
    end
  end
end