class OfferSave < ApplicationRecord
  belongs_to :offer, required: true
  belongs_to :candidate, required: true, foreign_key: "user_id"
end
