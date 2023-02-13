class Rating < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  validates :grade, presence: true
  validates :grade, inclusion: 1..5
end
