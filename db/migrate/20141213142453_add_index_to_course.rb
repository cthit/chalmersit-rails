class AddIndexToCourse < ActiveRecord::Migration
  def change
    add_index(:courses, :code)
  end
end
