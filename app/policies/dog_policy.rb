class DogsPolicy < ApplicationPolicy
  class Scope < Scope
  # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.where(owner:owner) # This is for owners to see their own dog
    end

    def show?
      return true
    end

    def create?
      return true
    end

    def edit?
      return update?
    end

    def update?
      return record.owner == owner
    end

    def destroy?
      return record.owner == owner
    end
  end
end
