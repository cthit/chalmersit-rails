class AddParentToPage < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :parent_id, :integer
    add_index :pages, :parent_id
  end
end
