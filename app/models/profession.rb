class Profession < ApplicationRecord
  extend FindOrCreate

  has_many :candidates
end
