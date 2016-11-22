class CreateFrontpages < ActiveRecord::Migration
  def change
    create_table :frontpages do |t|
      t.belongs_to :page, index: true
      t.timestamps null: false
    end
  end
end
