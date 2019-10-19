class RenameImagesToUploads < ActiveRecord::Migration[5.0]
  def change
    rename_table :images, :uploads
  end
end
