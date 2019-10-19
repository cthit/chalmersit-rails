class CreateCommittees < ActiveRecord::Migration[5.0]
  def change
    create_table :committees do |t|
      t.string :name
      t.string :title
      t.text :description
      t.string :url
      t.string :email
      t.string :slug

      t.index :slug

      t.timestamps
    end
  end
end
