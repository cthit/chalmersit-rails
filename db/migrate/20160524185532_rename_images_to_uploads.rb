class RenameImagesToUploads < ActiveRecord::Migration
  def change
    rename_table :images, :uploads
  end
end
