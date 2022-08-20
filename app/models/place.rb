class Place < ApplicationRecord
  belongs_to :address
  has_and_belongs_to_many :category_dictionaries
end
