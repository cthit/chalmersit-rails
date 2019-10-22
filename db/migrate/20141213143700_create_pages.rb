class CreatePages < ActiveRecord::Migration[5.0]
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
