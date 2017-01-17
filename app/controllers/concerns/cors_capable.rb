module CorsCapable
  extend ActiveSupport::Concern

  included do
    after_action :allow_cors

    protected
      def allow_cors
        response.headers['Access-Control-Allow-Origin']  = '*'
        response.headers['Access-Control-Allow-Methods'] = 'GET, POST, DELETE, PUT, PATCH'
        response.headers['Access-Control-Allow-Headers'] = request.headers['Access-Control-Request-Headers']
      end
  end
end
