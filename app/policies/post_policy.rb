class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # This will set the general scope of the all the actions,
    # - Either anyone can have access
    # - Either only the user who can access to their related posts.
    def resolve
      # scope.all
      scope.where(user: current_devise_api_user)
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    @record.user == @current_devise_api_user
  end

  def destroy?
    # @record.user == @current_devise_api_user
    true
  end

end
