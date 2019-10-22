class CreateMenuLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_links do |t|
      t.references :menu, index: true
      t.string :controller
      t.string :action
      t.string :params
      t.string :title
      t.integer :preferred_order

      t.timestamps
    end
  end
end
