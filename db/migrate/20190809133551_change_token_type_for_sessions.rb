class ChangeTokenTypeForSessions < ActiveRecord::Migration[5.0]
  def change
    change_column :sessions, :token, :text
  end
end
