class AddOptionsToSponsors < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :title, :string
    add_column :sponsors, :order, :integer
    Sponsor.create_translation_table! :title => :string
  end
end
