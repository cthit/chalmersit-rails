class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :user_id, limit: 20, null: false
      t.string :group_id, limit: 20
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :sticky, null: false, default: false
      t.timestamps

      t.index :user_id
      t.index :group_id
      t.index :title
    end
  end
end
