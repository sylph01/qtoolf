class EventsController < ApplicationController
  def index
    @events = Event.where('active = ?', true)
  end

  def show
    @event = Event.find(params[:id])
  end

  def history
    @event = Event.find(params[:id])
    @player_name = params[:player_name]
    @scores = @event.scores_of_player(@player_name)
  end
end
