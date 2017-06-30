class Subscription < ApplicationRecord
  belongs_to :company, required: true

  def active?
    !!valid_thru && valid_thru > Time.now
  end

  def activate_or_prolong!(time = 1.month)
    if active?
      update(valid_thru: valid_thru + time)
    else
      update(valid_thru: time.from_now)
    end
  end
end
