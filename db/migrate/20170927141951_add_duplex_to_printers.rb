class AddDuplexToPrinters < ActiveRecord::Migration[5.0]
  def change
    add_column :printers, :duplex, :boolean, default: true
  end
end
