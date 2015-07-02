class MenuLink < ActiveRecord::Base
  belongs_to :menu
  serialize :params, Hash

  def url_params
    self.params || {}
  end

  def path
    @path ||= Rails.application.routes.url_helpers.url_for url_params.merge! controller: controller, action: action, only_path: true
  end
end
