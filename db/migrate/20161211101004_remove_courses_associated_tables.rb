class RemoveCoursesAssociatedTables < ActiveRecord::Migration
  def change
    drop_table :courses_periods
    drop_table :periods
  end
end
