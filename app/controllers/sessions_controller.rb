class SessionsController < ApplicationController
  protect_from_forgery

  def create
    s = Session.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = s.uid
    redirect_to root_url, :notice => t('signed_in')
  end

  def destroy
    session[:user_id] = nil
    redirect_to logout_path(root_url)
    # redirect_to root_url, notice: :signed_out
  end
end
