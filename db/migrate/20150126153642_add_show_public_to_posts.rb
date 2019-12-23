class AddShowPublicToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :show_public, :boolean
  end
end
