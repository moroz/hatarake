class Application < ApplicationRecord
  belongs_to :offer, required: true
  belongs_to :candidate, required: true

  validates :candidate, uniqueness: { scope: :offer_id }
end
