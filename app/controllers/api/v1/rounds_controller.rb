module Api
  module V1
    class RoundsController < Api::V1::BaseController
      def show
        @round = Round.find(params[:id])
        @stats = @round.matches.flat_map(&:calculate_statistics)
      end
    end
  end
end
