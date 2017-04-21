class Country < ApplicationRecord
  has_many :offers
  validates_presence_of :iso, :name_en, :name_pl
  validates_uniqueness_of :iso, :name_en, :name_pl
end
