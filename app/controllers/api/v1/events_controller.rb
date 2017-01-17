module Api
  module V1
    class EventsController < Api::V1::BaseController
      def index
        @events = Event.all
      end

      def show
        @event = Event.find(params[:id])
      end
    end
  end
end
