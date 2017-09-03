class WorkItem < CvItem
  validates_presence_of :position

  belongs_to :location
end
