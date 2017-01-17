class EventsController < ApplicationController
  def index
    @events = Event.where('active = ?', true)
  end

  def show
    @event = Event.find(params[:id])
  end
end
