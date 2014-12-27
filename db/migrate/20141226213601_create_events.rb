class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :event_date
      t.boolean :full_day
      t.time :start_time
      t.time :end_time
      t.string :location
      t.string :organizer
      t.references :post, index: true
    end
  end
end
