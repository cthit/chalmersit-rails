class PagePolicy < ApplicationPolicy

  def show?
    super
  end

  def update?
    super
  end

  def edit?
    update?
  end
end
