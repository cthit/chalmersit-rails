class AddFacebookLinkToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :facebook_link, :string
  end
end
