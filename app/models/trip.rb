class Trip < ApplicationRecord
  cattr_accessor :current_user

  belongs_to :user

  has_many :trip_place_infos
  has_many :places, through: :trip_place_infos
  has_many :journeys
  has_many :users, through: :user_favorite_trips

  def favorite
    UserFavoriteTrip.where(user_id: current_user.id, trip_id: id).present?
  end
end
