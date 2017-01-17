class Admin::RoundsController < Admin::BaseController
  include OwnershipCheckable
  # Rounds do not need an indexing function, because its index is
  # listed in the Events page.
  COURT_NAMES = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  def result
    @round = Round.includes(matches: [:scores]).find(params[:id])
    gon.round_id = @round.id
  end

  def show
    @round = Round.includes(matches: [:scores]).find(params[:id])
  end

  def new
    if !params[:event_id]
      redirect_to admin_events_path, notice: 'No Event ID specified for round generation!'
    end
    @round = Round.new
    @round.event_id = event_id_param.to_i
    check_contributorship
  end

  def edit
    @round = Round.find(params[:id])
    check_contributorship
  end

  def create
    @round = Round.new(round_params)
    if check_contributorship
      if @round.save
        if !names_params.blank?
          names = names_params.rstrip.split(/\r?\n/).map(&:chomp)
          if shuffle_params
            names = names.shuffle
          end
          names.extend(ArrayHelper)
          names.insert_dummy.each_slice(4).to_a.each_with_index do |slice, index|
            Match.create({
              round_id: @round.id,
              court: COURT_NAMES[index % courts_params],
              number: (index / courts_params) + 1,
              scores_attributes: slice.each_with_index.map { |n, i| {name: n, order: i + 1} }
            })
          end
        end
        redirect_to admin_round_path(@round), notice: 'Round created!'
      else
        render action: "new"
      end
    end
  end

  def update
    @round = Round.find(params[:id])
    if check_contributorship
      if @round.update_attributes(round_params)
        redirect_to admin_round_path(@round), notice: 'Round updated!'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @round = Round.find(params[:id])
    event = @round.event
    if check_contributorship
      @round.destroy
      redirect_to admin_event_url(event), notice: "Round #{@round.name} deleted!"
    end
  end

  private
  def event_id_param
    params.permit(:event_id)[:event_id]
  end

  def round_params
    params.require(:round).permit(:name, :description, :event_id)
  end

  def names_params
    params.permit(:names)[:names]
  end

  def courts_params
    params.permit(:courts)[:courts].to_i
  end

  def shuffle_params
    params.permit(:shuffle)[:shuffle]
  end

  def check_ownership
    check_ownership_of(@round, @current_user)
  end

  def check_contributorship
    check_contributorship_of(@round, @current_user)
  end
end
