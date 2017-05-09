class Application < ApplicationRecord
  belongs_to :offer, required: true
  belongs_to :candidate, required: true

  validates :offer, uniqueness: { scope: :candidate_id }
  validates :memo, length: { maximum: 600 }
end
