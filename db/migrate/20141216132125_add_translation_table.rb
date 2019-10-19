class AddTranslationTable < ActiveRecord::Migration[5.0]
  def up
    Post.create_translation_table! :title => :string, :body => :text, :slug => :string
  end

  def down
    Post.drop_translation_table!
  end
end
