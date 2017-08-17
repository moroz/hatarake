class BlogPost < ApplicationRecord
  belongs_to :company, required: true, foreign_key: 'user_id'

  validates :body, length: { minimum: 10, maximum: 5000 }
  validates :body, uniqueness: { scope: :user_id }
  scope :ordered, -> { order(:created_at => :desc) }

  before_validation :remove_trailing_whitespace

  private

  def remove_trailing_whitespace
    self.body.strip!
  end
end
