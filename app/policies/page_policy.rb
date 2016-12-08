class PagePolicy < ApplicationPolicy

  def show?
    super
  end

  def create?
    super || (user && !(user.committees.select { |c| page_admins.include?(c.slug)  }).empty?)
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
private
  def page_admins
    ["styrit", "armit", "snit"]
  end
end
