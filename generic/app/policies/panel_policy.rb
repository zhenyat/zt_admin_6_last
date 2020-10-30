class PanelPolicy < ApplicationPolicy

  # For index
  class Scope < Scope
    def resolve
      scope.all
#      if (user.superadmin? || user.admin? || user.manager?)
#        scope.all
#      else
#        nil
#      end
    end
  end

  def show?
    user.superadmin? || user.admin? || user.manager?
  end

  def create?
    user.superadmin? || user.admin?
  end

  def new?
    create?
  end

  def edit?
    user.superadmin? || user.admin? || user.manager?
  end

  def update?
    user.superadmin? || user.admin? || user.manager?
  end

  def destroy?
    user.superadmin? || user.admin?
  end
end
