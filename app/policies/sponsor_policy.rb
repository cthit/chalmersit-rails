class SponsorPolicy < ApplicationPolicy

  def index?
    create?
  end

  def show?
    create?
  end

  def create?
    super || (user && user.committees_include_any?(Sponsor.sponsor_admins))
  end

  def update?
    create?
  end
  
  def destroy?
    create?
  end
end
