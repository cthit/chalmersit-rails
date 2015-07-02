class AddFacebookLinkToEvent < ActiveRecord::Migration
  def change
    add_column :events, :facebook_link, :string
  end
end
