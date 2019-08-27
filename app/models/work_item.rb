# frozen_string_literal: true

class WorkItem < CvItem
  validates_presence_of :position

  belongs_to :location, optional: true
end
