class Admin::ContributorsController < Admin::BaseController
  include OwnershipCheckable
  def create
    @contributor = Contributor.new(contributor_params)
    if check_ownership
      if @contributor.save
        redirect_to admin_event_path(@contributor.event), notice: 'Contributor added!'
      else
        redirect_to admin_event_path(@contributor.event)
      end
    end
  end

  def destroy
    @contributor = Contributor.find(params[:id])
    event = @contributor.event
    if check_ownership
      @contributor.destroy
      redirect_to admin_event_path(event)
    end
  end

  private
  def contributor_params
    params.require(:contributor).permit(:screen_name, :event_id)
  end

  def check_ownership
    check_ownership_of(@contributor.event, @current_user)
  end
end
