class AddDocumentsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :documents, :string
  end
end
