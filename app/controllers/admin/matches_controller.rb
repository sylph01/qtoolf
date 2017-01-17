require 'uri'

class Admin::MatchesController < Admin::BaseController
  include OwnershipCheckable
  def new
    if params[:round_id].nil?
      redirect_to admin_root_url, alert: "Round ID not specified!"
    end
    @match = Match.new
    @match.round_id = params[:round_id].to_i
    4.times { @match.scores.build }
    check_contributorship
  end

  def create
    @match = Match.new(match_params)
    if check_contributorship
      if @match.save
        redirect_to admin_round_path(@match.round), notice: 'Match created!'
      else
        render action: "new"
      end
    end
  end

  def show
    @match = Match.includes(:scores).find(params[:id])

    content = "#{@match.round.name} / #{@match.name}\n"
    @match.scores.each do |score|
      rank = @match.scores.to_a.count { |sx| sx.score.to_f > score.score.to_f } + 1
      content += "#{score.name}:#{score.genre}/#{score.kind}-#{score.score}(#{rank})\n"
    end
    @twitter_content = URI.escape(content.chomp)
  end

  def edit
    @match = Match.includes(:scores).find(params[:id])
    check_contributorship
  end

  def update
    @match = Match.find(params[:id])
    if check_contributorship
      if @match.update_attributes(match_params)
        redirect_to admin_match_path(@match), notice: 'Match updated!'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @match = Match.find(params[:id])
    name  = @match.name
    round = @match.round
    if check_contributorship
      @match.destroy
      redirect_to admin_round_path(round), notice: "Match #{name} deleted!"
    end
  end

  private
  def match_params
    params.require(:match).permit(:court, :number, :round_id, :image, scores_attributes: [:id, :name, :score, :genre, :kind])
  end

  def check_ownership
    check_ownership_of(@match, @current_user)
  end

  def check_contributorship
    check_contributorship_of(@match, @current_user)
  end
end
