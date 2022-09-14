class Journey < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  validate :only_one_uncompleted, on: :create

  def only_one_uncompleted
    if user.journeys.where(completed: [nil, false]).present?
      errors.add(:completed, "User can have only one uncompleted journey.")
    end
  end
end
