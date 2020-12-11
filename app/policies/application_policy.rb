class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user_is_admin?
  end

  def new?
    create?
  end

  def update?
    user_is_admin?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_admin?
  end

  private
    def user_is_admin?
      user && user.is_admin?
    end
end
