class MatchesController < ApplicationController
  def show
    @match = Match.includes(:scores).find(params[:id])
  end
end
