class CommentPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def destroy?
    super || user == resource.user
  end
end

