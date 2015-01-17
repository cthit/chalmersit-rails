class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :uid, index: true
      t.string :provider, index: true
      t.string :token

      t.timestamps
    end
  end
end
