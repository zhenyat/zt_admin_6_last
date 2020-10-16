### This policy is special!

class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.superadmin?
  end

  def show?
    @current_user.superadmin? || @current_user.admin?|| @current_user == @user
  end

  def create?
    @current_user.superadmin?
  end

  def new?
    create?
  end

  def edit?
    @current_user.superadmin? || @current_user == @user
  end

  def update?
    @current_user.superadmin? || @current_user == @user
  end

  def destroy?
    @current_user.superadmin?
  end
end