class BlogPost < ApplicationRecord
  belongs_to :company, required: true, foreign_key: 'user_id'

  validates :body, length: { minimum: 10, maximum: 1000 }
  scope :ordered, -> { order(:created_at => :desc) }
end
