class Page < ApplicationRecord
  validates :permalink, uniqueness: true
end
