class CvItem < ApplicationRecord
  belongs_to :candidate
  attr_accessor :start_month, :start_year, :end_month, :end_year

  TYPES = %w( internship ba ma engineer phd work owner founder )

  validates_presence_of :start_date, :type, :position, :candidate 
  validates :type, inclusion: { in: TYPES }

  before_validation :make_dates

  private

  def make_dates
    if start_month.present? && start_year.present?
      self.start_date = Date.new(start_year.to_i, start_month.to_i)
    end
    if end_month.present? && end_year.present?
      self.end_date = Date.new(end_year.to_i, end_month.to_i)
    end
  end
end
