class AddValueToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :value, :text
  end
end
