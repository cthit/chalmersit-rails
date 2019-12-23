class AddTranslationTableToCourses < ActiveRecord::Migration[5.0]
  def up
    Course.create_translation_table! :name => :string, :description => :text if defined? Course
  end

  def down
    Course.drop_translation_table! if defined? Course
  end
end
