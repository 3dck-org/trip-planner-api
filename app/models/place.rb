class Place < ApplicationRecord
  belongs_to :address
  has_and_belongs_to_many :category_dictionaries
  has_many :trip_place_infos
  has_many :trips, through: :trip_place_infos
  has_many :journey_place_infos

  def google_maps_url
    "https://www.google.com/maps/place/#{point.x},#{point.y}" rescue nil
  end
end
