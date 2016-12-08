class PagePolicy < ApplicationPolicy

  def show?
    super
  end

  def create?
    super || (user && user.committees_include_any?(Page.page_admins))
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def destroy?
    update?
  end

  def delete_document?
    update?
  end
end
