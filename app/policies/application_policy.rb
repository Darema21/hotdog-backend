# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :owner, :record

  def initialize(owner, record)
    @owner = owner
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(owner, scope)
      @owner = owner
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :owner, :scope
  end
end
