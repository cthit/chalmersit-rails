class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :slug
      
      t.index :title
      t.index :slug


      t.timestamps
    end
  end
end
