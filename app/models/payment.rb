class Payment < ApplicationRecord
  belongs_to :subscription
  belongs_to :subscription_price
end
