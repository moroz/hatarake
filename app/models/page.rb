class Page < ApplicationRecord
  validates :permalink, uniqueness: true, presence: true
  before_save :strip_lines

  def strip_lines
    self.body = body.lines.map { |l|
      l.strip
    }.join("\n")
  end

  def to_param
    permalink
  end
end
