class AddDocumentsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :documents, :string
  end
end
