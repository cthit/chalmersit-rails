class MenuLink < ActiveRecord::Base
  belongs_to :menu

  def path
    @path ||= Rails.application.routes.url_helpers.url_for controller: controller, action: action, only_path: true
  end
end
