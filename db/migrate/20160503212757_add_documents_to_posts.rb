class AddDocumentsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :documents, :string
  end
end
