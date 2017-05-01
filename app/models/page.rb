class Page < ApplicationRecord
  validates :permalink, uniqueness: true, presence: true
  validates :body_en, presence: true
  before_save :strip_lines

  def to_param
    permalink
  end

  def local_body
    if I18n.locale == :pl
      body_pl || body_en
    else
      body_en
    end
  end

  private

  def strip_lines
    keys = [:body_en, :body_pl]
    keys.each do |key|
      content = self[key]
      unless content.nil?
        self[key] = content.lines.map { |l|
          l.strip
        }.join("\n")
      end
    end
  end
end
