class CreatePrinters < ActiveRecord::Migration[5.0]
  def change
    create_table :printers do |t|
      t.string :name
      t.string :location
      t.string :media
      t.integer :weight, default: 10
    end
  end
end
