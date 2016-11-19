class Frontpage < ActiveRecord::Base
  before_create :only_one_row
  has_one :page

  private
  def only_one_row
    raise "You can create only one row of this table" if Frontpage.count > 0
  end

end
