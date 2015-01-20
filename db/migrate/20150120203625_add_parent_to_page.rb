class AddParentToPage < ActiveRecord::Migration
  def change
    add_column :pages, :parent_id, :integer
    add_index :parent_id
  end
end
