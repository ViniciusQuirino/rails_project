class CategoryPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin? || user.has_role?(:moderator)
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def index?
    user&.admin? || user&.has_role?(:moderator)
  end

  def create?
    user.admin? || user.has_role?(:moderator)
  end

  def update?
    user.admin? || user.has_role?(:moderator)
  end

  def destroy?
    user.admin?
  end
end
