module Api
  module V1
    class BaseController < ActionController::Base
      include CorsCapable
    end
  end
end
