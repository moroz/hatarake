class Application < ApplicationRecord
  belongs_to :offer, required: true
  belongs_to :candidate, required: true

end
