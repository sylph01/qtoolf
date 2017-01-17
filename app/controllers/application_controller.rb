class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_current_user, :set_request_from

  def load_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def login_required
    if !session[:user_id]
      flash[:alert] = 'Login required!'
      redirect_to root_path
    end
  end

  # http://qiita.com/azusanakano/items/8af1266f53a656ef787d
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    session[:request_from] = request.original_url
  end

  def return_back(options = {})
    if request.referer
      redirect_to(:back, options) and return true
    elsif @request_from
      redirect_to(@request_from, options) and return true
    else
      # if all else fails, return to root
      redirect_to(root_path, options)
    end
  end
end
