class ChangeParamsColumnTypeMenuLinks < ActiveRecord::Migration
  def up
    change_column :menu_links, :params, :text
  end

  def down
    change_column :menu_links, :params, :string
  end
end
