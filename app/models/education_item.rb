class EducationItem < CvItem
  attr_accessor :start_month, :start_year, :end_month, :end_year, :organization_name
  validates_presence_of :specialization
  before_validation :make_dates, :swap_dates, :find_or_create_organization
end
