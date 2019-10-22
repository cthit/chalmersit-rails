class SoftRemovalOfPrinters < ActiveRecord::Migration[5.0]
  def change
    add_column :printers, :deleted, :boolean, default: false
  end
end
