# frozen_string_literal: true

class SubscriptionPrice < ApplicationRecord
  has_many :payments
end
