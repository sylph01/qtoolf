class RoundsController < ApplicationController
  def show
    @round = Round.includes(:matches => [:scores]).find(params[:id])
  end

  def result
    @round = Round.includes(:matches => [:scores]).find(params[:id])
    gon.round_id = @round.id
  end
end
