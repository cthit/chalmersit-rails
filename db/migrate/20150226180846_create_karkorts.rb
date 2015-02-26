class CreateKarkorts < ActiveRecord::Migration
  def change
    create_table :karkorts do |t|
      t.string :cid, null: false
      t.string :card_number, null: false
      t.timestamps
    end
  end
end
