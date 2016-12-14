class Menu < ActiveRecord::Base
  has_many :links, class_name: 'MenuLink'

  def self.links_for_menu_cached(menu_name)
    Rails.cache.fetch(Menu.where(name: menu_name).last) do
      Menu.where(name: menu_name).last.links.sort_by{|l| l.preferred_order}.to_a
    end
  end
end
