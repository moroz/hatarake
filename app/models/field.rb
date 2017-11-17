# frozen_string_literal: true

class Field < ApplicationRecord
  has_many :offers
  include Localizable
end
