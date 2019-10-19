class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.text :title
      t.text :body
      t.string :email
      t.text :to_whom

      t.timestamps null: false
    end
  end
end
