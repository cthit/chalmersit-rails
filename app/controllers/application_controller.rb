class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      session[:user_id] = nil
      redirect_to root_url, alert: "Access token expired, try signing in again."
    end
  end

  before_action :set_committees, :set_locale

  private
    def set_committees
      @committees = Committee.all
    end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { :locale => locale_or_nil }
  end
end
