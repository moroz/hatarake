class Profession < ApplicationRecord
  include FindOrCreate
  include ActsLikeAutocompletable
  include Localizable

  has_many :candidates
end
