class Subscription < ApplicationRecord
  belongs_to :company, required: true

  def is_valid?
    valid_thru > Time.now
  end

  def approve!(duration: 1)
    self.update(valid_thru: duration.months.from_now)
  end
end
