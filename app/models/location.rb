class Location < ApplicationRecord
  belongs_to :country
  belongs_to :province
end
