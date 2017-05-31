class Country < ApplicationRecord
  include Localizable

  has_many :offers
  has_many :provinces
  scope :abroad, -> { where('id != ?', POLAND_ID) }
  validates_presence_of :iso, :name_en, :name_pl
  validates_uniqueness_of :iso, :name_en, :name_pl

  POLAND_ID = 166
end
