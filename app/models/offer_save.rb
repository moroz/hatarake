# frozen_string_literal: true

class OfferSave < ApplicationRecord
  belongs_to :offer, required: true
  belongs_to :user, required: true, foreign_key: 'user_id'

  validates :offer_id, uniqueness: { scope: :user_id }
end
