class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :user_id
      t.string :document

      t.timestamps null: false
    end
  end
end
