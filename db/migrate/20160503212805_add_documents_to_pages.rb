class AddDocumentsToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :documents, :string
  end
end
