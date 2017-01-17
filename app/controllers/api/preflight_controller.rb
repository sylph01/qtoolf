module Api
  class PreflightController < ActionController::Base
    include CorsCapable

    def preflight
      head status: 200
    end
  end
end
