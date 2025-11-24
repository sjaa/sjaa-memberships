# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def signup?
    true
  end

  def signup_2?
    true
  end

  def index?
    user&.has_permission? :read
  end

  def search?
    user&.has_permission? :read
  end

  def show?
    user&.has_permission? :read
  end

  def create?
    user&.has_permission? :write
  end

  def add_person?
    user&.has_permission? :write
  end

  def new?
    user&.has_permission? :write
  end

  def update?
    user&.has_permission? :write
  end

  def edit?
    user&.has_permission? :write
  end

  def destroy?
    user&.has_permission? :write
  end

  def create_order?
    true
  end

  def capture_order?
    true
  end

  def send_letter?
    true
  end

  def preview_letter?
    true
  end

  def send_letter_with_options?
    true
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
