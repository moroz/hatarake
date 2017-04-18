class CvItem < ApplicationRecord
  belongs_to :candidate
  belongs_to :organization
  attr_accessor :start_month, :start_year, :end_month, :end_year,
    :organization_name

  CATEGORIES = %w( internship ba ma engineer phd work owner founder )
  # This field was meant to be called type, but that's reserved
  # for Active Record's STI, so it was renamed
  EDUCATIONAL = %w( ba ma engineer phd )

  scope :education_items, -> { where('category IN (?)', EDUCATIONAL) }
  scope :work_items, -> { where('category NOT IN (?)', EDUCATIONAL) }
  scope :ordered, -> { order('end_date DESC NULLS FIRST', 'start_date DESC') }
  default_scope { includes(:organization).ordered }

  validates_presence_of :start_date, :category, :position,
    :candidate 
  validates :category, inclusion: { in: CATEGORIES }

  before_validation :make_dates, :swap_dates, :find_or_create_organization

  def education?
    self.category.in? EDUCATIONAL
  end

  def work?
    !education?
  end

  private

  def make_dates
    if start_month.present? && start_year.present?
      self.start_date = Date.new(start_year.to_i, start_month.to_i)
    end
    if end_month.present? && end_year.present?
      self.end_date = Date.new(end_year.to_i, end_month.to_i)
    end
  end

  def swap_dates
    if end_date.present? && start_date.present? && end_date < start_date
      end_date, start_date = start_date, end_date
    end
  end

  def find_or_create_organization
    self.organization = Organization.find_or_create_by_name(organization_name)
  end
end
