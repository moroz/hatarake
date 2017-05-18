class Location < ApplicationRecord
  belongs_to :country, required: true
  belongs_to :province

  attr_accessor :country_name, :province_name

  has_one :company
  has_one :offer

  before_validation :find_country_and_province

  def to_s
    if province.present? || city.present?
      [city, province.try(:local_name), country.try(:local_name)].reject(&:blank?).join(', ')
    else
      country.local_name + " – " + I18n.t('offers.provinces.blank')
    end
  end

  def short_format
    [city, country.local_name].reject(&:blank?).join(', ')
  end

  private

  def find_country_and_province
    if self.country_name.present?
      self.country = Country.find_by_local_name(country_name)
    end
    if self.province_name.present?
      self.province = Province.find_by_local_name(province_name)
    end
  end
end
