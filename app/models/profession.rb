class Profession < ApplicationRecord
  include FindOrCreate
  include ActsLikeAutocompletable

  has_many :candidates
end
