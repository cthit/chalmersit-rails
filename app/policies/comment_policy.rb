class CommentPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def destroy?
    super || user == record.user
  end
end

