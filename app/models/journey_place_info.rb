class JourneyPlaceInfo < ApplicationRecord
  belongs_to :journey
  belongs_to :place

  validates :status, inclusion: %w[inactive active visited]
end
