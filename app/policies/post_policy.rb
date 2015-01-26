class PostPolicy < ApplicationPolicy

  def show?
    super # TODO: https://github.com/cthit/chalmersit-rails/issues/29
  end

  def create?
    super || (user && user.in_committee?)
  end

  def update?
    super || (user && user.committees.include?(record.group))
  end

  def destroy?
    update?
  end
end

