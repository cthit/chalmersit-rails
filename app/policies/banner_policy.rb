class BannerPolicy < ApplicationPolicy

  def show?
    create?
  end

  def create?
    super || (user && user.in_committee?)
  end

  def update?
    super || (user && user.committees.include?(record.group))
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
