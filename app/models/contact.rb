class Contact < ActiveRecord::Base
  def self.available_mails
    %w(styrit@chalmers.it samo@chalmers.it snit@chalmers.it valberedningen@chalmers.it digit@chalmers.it)
  end
end
