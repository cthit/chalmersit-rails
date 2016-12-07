class AddOptionsToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :title, :string
    add_column :sponsors, :order, :integer
    Sponsor.create_translation_table! :title => :string
  end
end
