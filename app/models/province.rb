class Province < ApplicationRecord
  belongs_to :country
  include Localizable
end
