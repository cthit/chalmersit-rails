class AddTranslationTableToCommittees < ActiveRecord::Migration
  def up
    Committee.create_translation_table! :title => :string, :description => :text
  end

  def down
    Committee.drop_translation_table!
  end
end
