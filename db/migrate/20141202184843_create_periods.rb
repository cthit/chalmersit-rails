class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :name
      t.timestamps
    end
  end
end
