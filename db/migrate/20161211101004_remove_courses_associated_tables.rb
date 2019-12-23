class RemoveCoursesAssociatedTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :courses_periods
    drop_table :periods
  end
end
