class AddShowPublicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :show_public, :boolean
  end
end
