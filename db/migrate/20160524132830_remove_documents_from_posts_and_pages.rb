class RemoveDocumentsFromPostsAndPages < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :documents
    remove_column :pages, :documents
  end
end
