# frozen_string_literal: true

class NewsletterSubscription < ApplicationRecord
  validates :email, presence: true, format:
            { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, allow_blank: true }, uniqueness: true
end
