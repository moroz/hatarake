class Profession < ApplicationRecord
  extend FindOrCreate
  extend ActsLikeAutocompletable

  has_many :candidates
end
