class MenuLink < ActiveRecord::Base
  belongs_to :menu, touch: true
  serialize :params, Hash

  def url_params
    self.params || {}
  end

  def path
    @path ||= Rails.application.routes.url_helpers.url_for url_params.merge!({
      controller: controller,
      action: action,
      locale: I18n.default_locale == I18n.locale ? nil : I18n.locale,
      only_path: true
    })
  end
end
