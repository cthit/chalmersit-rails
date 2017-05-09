class AddTranslationsToUserGroupInfo < ActiveRecord::Migration
  def up
    UserGroupInfo.create_translation_table! :body => :string
  end

  def down
    UserGroupInfo.drop_translation_table!
  end
end
