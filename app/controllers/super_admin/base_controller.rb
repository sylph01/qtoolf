class SuperAdmin::BaseController < ApplicationController
  before_action :login_required
  before_action :super_admin_required

  def super_admin_required
    if !session[:user_id]
      flash[:alert] = 'Admin privilege required!'
      redirect_to root_path
    else
      @current_user = User.find(session[:user_id])
      if !@current_user.admin
        flash[:alert] = 'Admin privilege required!'
        redirect_to root_path
      end
    end
  end
end
