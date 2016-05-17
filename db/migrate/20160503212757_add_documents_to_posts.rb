class AddDocumentsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :documents, :json
  end
end
