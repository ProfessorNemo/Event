class EventPolicy < ApplicationPolicy
  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  def create?
    user.present?
  end

  private

  def user_is_owner?(event)
    user.present? && event&.user == user
  end
end
