class Offer < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :skills
  validates_presence_of :currency, :company

  def salary
    if salary_min.present?
      if salary_max.present?
        "#{salary_min}-#{salary_max} #{currency}"
      else
        "#{salary_min}+ #{currency}"
      end
    else
      if salary_max.present?
        "up to #{salary_max} #{currency}"
      else
        "n/a"
      end
    end
  end
end
