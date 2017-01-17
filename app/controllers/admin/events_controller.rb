class Admin::EventsController < Admin::BaseController
  include OwnershipCheckable
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @contributor = Contributor.new
    @contributor.event_id = @event.id
    @is_owner = is_owner?(@event, @current_user)
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
    check_ownership
  end

  def create
    @event = Event.new(event_params)
    @event.owner_id = @current_user.id

    if @event.save
      redirect_to admin_event_path(@event), notice: 'Event created!'
    else
      render action: "new"
    end
  end

  def update
    @event = Event.find(params[:id])
    if check_ownership
      if @event.update_attributes(event_params)
        redirect_to admin_event_path(@event), notice: 'Event updated!'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if check_ownership
      @event.destroy
      redirect_to admin_events_url, notice: "Event #{@event.name} deleted!"
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :active, :description)
  end

  def check_ownership
    check_ownership_of(@event, @current_user)
  end

  def check_contributorship
    check_contributorship_of(@event, @current_user)
  end
end
