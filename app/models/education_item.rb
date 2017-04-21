class EducationItem < ApplicationRecord
  attr_accessor :organization_name

  belongs_to :organization
  belongs_to :candidate
  before_validation :find_or_create_organization

  private

  def find_or_create_organization
    self.organization = organization_name.present? ? Organization.find_or_create_by_name(organization_name) : nil
  end
end
