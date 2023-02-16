class Trip < ApplicationRecord
  cattr_accessor :current_user

  belongs_to :user

  has_many :trip_place_infos, dependent: :destroy
  has_many :places, through: :trip_place_infos, dependent: :destroy
  has_many :journeys, dependent: :destroy
  has_many :user_favorite_trips, dependent: :destroy
  has_many :ratings, dependent: :destroy

  def favorite
    UserFavoriteTrip.where(user_id: current_user.id, trip_id: id).present?
  end

  def average_rating
    Rating.where(trip_id: id).average(:grade)
  end
end
