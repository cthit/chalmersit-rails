class CreateBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :banners do |t|
      t.string :image
      t.string :group_id, limit: 20
      
      t.timestamps null: false
    end
  end
end
