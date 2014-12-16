class AddTranslationTableToCourses < ActiveRecord::Migration
  def up
    Course.create_translation_table! :name => :string, :description => :text
  end

  def down
    Course.drop_translation_table!
  end
end
