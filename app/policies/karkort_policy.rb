class KarkortPolicy < ApplicationPolicy

  def fetch?
    user.card == record
  end
end

