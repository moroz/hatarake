class Location < ApplicationRecord
  belongs_to :country, required: true
  belongs_to :province, required: true

  has_one :company
  validates :city, presence: true

  def to_s
    if province.present?
      [city, province.local_name, country.local_name].join(', ')
    else
      country.local_name + " – " + I18n.t('offers.provinces.blank')
    end
  end

  def short_format
    city + ', ' + country.local_name
  end
end
