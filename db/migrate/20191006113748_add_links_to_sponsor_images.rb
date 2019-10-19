class AddLinksToSponsorImages < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :imagelink, :string, :null => true, :default => nil
  end
end
