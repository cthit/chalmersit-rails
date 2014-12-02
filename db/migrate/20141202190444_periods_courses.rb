class PeriodsCourses < ActiveRecord::Migration
  def change
    create_table :courses_periods, id: false do |t|
      t.integer :period_id
      t.integer :course_id
    end
  end
end
