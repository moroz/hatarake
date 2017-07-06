class Field < ApplicationRecord
  has_and_belongs_to_many :companies
  has_many :offers
  include Localizable
end
