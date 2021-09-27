class Event < ApplicationRecord
  belongs_to :user

  serialize :starts_at, IceCube::Schedule

  default_scope -> { order(created_at: :desc) }
end
