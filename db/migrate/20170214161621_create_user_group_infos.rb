class CreateUserGroupInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_group_infos do |t|
      t.string :user_id, limit: 20
      t.string :group_id, limit: 20
      t.string :body
      t.timestamps null: false
    end
  end
end
