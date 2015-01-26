class CoursePolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end

