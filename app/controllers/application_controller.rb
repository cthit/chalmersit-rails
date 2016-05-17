class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit
  before_filter :export_i18n_messages

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      session[:user_id] = nil
      redirect_to root_url, alert: "Access token expired, try signing in again."
  end
end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_committees, :set_locale

  private
    def export_i18n_messages
      SimplesIdeias::I18n.export! if Rails.env.development?
    end 
    def user_not_authorized
      flash[:alert] = t 'not_authorized'
      redirect_to(request.referrer || root_path)
    end

    def set_committees
      @committees = Committee.all.with_translations(I18n.locale)
    end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { :locale => locale_or_nil }
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  helper_method :current_user, :signed_in?
end
