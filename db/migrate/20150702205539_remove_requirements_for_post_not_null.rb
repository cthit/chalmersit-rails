class RemoveRequirementsForPostNotNull < ActiveRecord::Migration
  def change
    change_column_null(:posts, :title, true)
    change_column_null(:posts, :body, true)
  end
end
