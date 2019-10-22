class AddTranslationTableToCommittees < ActiveRecord::Migration[5.0]
  def up
    Committee.create_translation_table! :title => :string, :description => :text
  end

  def down
    Committee.drop_translation_table!
  end
end
