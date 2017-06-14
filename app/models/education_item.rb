class EducationItem < CvItem
  attr_accessor :start_month, :start_year, :end_month, :end_year
  validates_presence_of :specialization
  before_validation :swap_dates

  belongs_to :location
end
