class WorkItem < ApplicationRecord
  attr_accessor :organization_name

  belongs_to :organization, required: true
  belongs_to :candidate, required: true
  before_validation :find_or_create_organization

  validates_presence_of :organization

  private

  def find_or_create_organization
    self.organization = organization_name.present? ? Organization.find_or_create_by_name(organization_name) : nil
  end
end
