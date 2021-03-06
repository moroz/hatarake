# frozen_string_literal: true

class Application < ApplicationRecord
  belongs_to :offer, required: true
  belongs_to :candidate, required: true
  has_one :company, through: :offer
  scope :unread, -> { where('NOT read') }

  MAX_LENGTH = 4000

  def mark_as_read
    update(read: true)
  end

  def self.mark_all_as_read
    unread.update_all(read: true)
  end

  validates :offer, uniqueness: { scope: :candidate_id }
  validates :memo, length: { maximum: MAX_LENGTH }
end
