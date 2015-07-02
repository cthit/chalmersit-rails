class CommitteePolicy < ApplicationPolicy

  def update?
    super || (user && user.committees.include?(record))
  end
end

