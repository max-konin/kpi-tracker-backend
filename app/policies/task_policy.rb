class TaskPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def index?
    true
  end

  def update?
    is_user_a_creator?
  end

  def destroy?
    is_user_a_creator?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def is_user_a_creator?
    @record.user_id == @user.id
  end
end
