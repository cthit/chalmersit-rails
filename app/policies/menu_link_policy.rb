class MenuLinkPolicy < ApplicationPolicy

  def index?
    create?
  end

  def show?
    index?
  end
end
