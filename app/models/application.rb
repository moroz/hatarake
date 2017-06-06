class Application < ApplicationRecord
  belongs_to :offer, required: true
  belongs_to :candidate, required: true
  has_one :company, through: :offer
  scope :unread, -> { where(read: false) }

  def mark_as_read
    self.update(read: true)
  end

  def self.mark_all_as_read
    self.unread.update_all(read: true)
  end
  
  validates :offer, uniqueness: { scope: :candidate_id }
  validates :memo, length: { maximum: 600 }
end
