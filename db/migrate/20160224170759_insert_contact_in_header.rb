class InsertContactInHeader < ActiveRecord::Migration
  def change
    main_menu = Menu.where(name: "main").first
    link = { controller: "contact", action: "index", title: "Kontakt", preferred_order: 3 }
    MenuLink.create(link.merge(menu: main_menu))
  end
end
