class SoftRemovalOfPrinters < ActiveRecord::Migration
  def change
    add_column :printers, :deleted, :boolean, default: false
  end
end
