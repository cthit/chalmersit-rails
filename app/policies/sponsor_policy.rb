class SponsorPolicy < ApplicationPolicy

  def create?
    super || (user && user.committees_include_any?(Sponsor.sponsor_admins))
  end

  def update?
    create?
  end
end
