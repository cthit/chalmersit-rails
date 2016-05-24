class RemoveDocumentsFromPostsAndPages < ActiveRecord::Migration
  def change
    remove_column :posts, :documents
    remove_column :pages, :documents
  end
end
