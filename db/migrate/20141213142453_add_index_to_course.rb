class AddIndexToCourse < ActiveRecord::Migration[5.0]
  def change
    add_index(:courses, :code)
  end
end
