class Offer < ApplicationRecord
  belongs_to :company, required: true
  belongs_to :country, required: true
  has_and_belongs_to_many :skills
  validates_presence_of :currency
  validates :title, presence: true, length: { minimum: 10, maximum: 85 }
  CURRENCIES = I18n.t('currencies').stringify_keys.keys 
  validates :currency, inclusion: { in: CURRENCIES }

  def salary
    format = if salary_min.present?
      if salary_max.present?
        if salary_min == salary_max
          'mineqmax'
        else
          'minmax'
        end
      else
        'min'
      end
    else
      if salary_max.present?
        'max'
      else
        'none'
      end
    end
    I18n.t("offers.salary.#{format}", min: salary_min, max: salary_max, currency: currency)
  end
end
