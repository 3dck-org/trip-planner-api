class Trip < ApplicationRecord
  belongs_to :user

  has_many :trip_place_infos
  has_many :places, through: :trip_place_infos
end
