class CvItem < ApplicationRecord
  self.abstract_class = true

  belongs_to :candidate

  CATEGORIES = %w( internship ba ma engineer phd work owner founder )
  # This field was meant to be called type, but that's reserved
  # for Active Record's STI, so it was renamed

  scope :ordered, -> { order('end_date DESC NULLS FIRST', 'start_date DESC') }

  validates_presence_of :start_date, :category, :candidate, :organization
  validates :category, inclusion: { in: CATEGORIES }

  before_validation :swap_dates

  private

  def swap_dates
    if end_date.present? && start_date.present? && end_date < start_date
      end_date, start_date = start_date, end_date
    end
  end
end
