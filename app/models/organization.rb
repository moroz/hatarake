class Organization < ApplicationRecord
  extend FindOrCreate
  validates_presence_of :name
  validates_uniqueness_of :name, :name_pl
end
