class AddValueToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :value, :text
  end
end
