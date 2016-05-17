class ChangeDocumentsFormat < ActiveRecord::Migration
  def up
    change_column :pages, :documents, :string
    change_column :posts, :documents, :string
  end

  def down
    change_column :pages, :documents, :json
    change_column :posts, :documents, :json
  end
end
