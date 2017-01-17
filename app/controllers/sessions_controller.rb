class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path, :notice => "Hello and welcome @#{user.screen_name}!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Logged out!"
  end

  # for debug purposes
  def fake_session
    session[:user_id] = 1
    redirect_to root_path, :notice => "Hello and welcome fake user!"
  end
end
