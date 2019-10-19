class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.integer :year
      t.boolean :required
      t.string :homepage
      t.string :programme
      t.text :description

      t.timestamps
    end
  end
end
