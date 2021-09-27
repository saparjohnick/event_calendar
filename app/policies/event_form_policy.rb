class EventFormPolicy < ApplicationPolicy
  def update?
    record.user_id == current_user.id
  end

  def destroy?
    record.user_id == user.id
  end
end
