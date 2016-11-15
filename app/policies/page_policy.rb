class PagePolicy < ApplicationPolicy

  def show?
    super
  end

  def create?
    super
  end

  def update?
    super
  end

  def destroy?
    update?
  end

  def delete_document?
    update?
  end
end
