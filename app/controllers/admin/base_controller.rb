class Admin::BaseController < ApplicationController
  layout "admin"

  before_action :require_login

  def require_login
    if session[:user_id].nil? || User.find_by_id(session[:user_id]).nil?
      redirect_to root_path, alert: "You must be logged in!"
    end
  end
end
