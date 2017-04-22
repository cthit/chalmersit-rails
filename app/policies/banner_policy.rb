class BannerPolicy < ApplicationPolicy

  def index?
    false
  end

  def show?
    update?
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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user && user.admin?
        scope.all
      elsif user
        scope.where(group_id: user.committees.map{|c| c.slug})
      else
        scope.none
      end
    end
  end
end
