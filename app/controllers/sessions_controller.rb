class SessionsController < ApplicationController
  def create
    s = Session.from_omniauth(env["omniauth.auth"])
    session[:user_id] = s.uid
    redirect_to root_url, notice: :signed_in
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: :signed_out
  end
end
