class Location < ApplicationRecord
  belongs_to :country, required: true
  belongs_to :province

  attr_accessor :country_name, :province_name

  has_one :company
  has_one :offer

  before_validation :find_country_and_province

  def to_s
    if province.present? || city.present?
      if country.id == Country::POLAND_ID && I18n.locale == :pl
        return [city, province.try(:local_name)].reject(&:blank?).join(', ')
      end
      [city, province.try(:local_name), country.local_name].reject(&:blank?).join(', ')
    else
      country.local_name + " – " + I18n.t('offers.provinces.blank')
    end
  end

  def short_format
    short_format_base.reject(&:blank?).join(', ')
  end

  def short_with_line_breaks
    short_format_base.reject(&:blank?).join('<br/>').html_safe
  end

  private

  def short_format_base
    if country_id == Country::POLAND_ID
      [city, province.try(:local_name)]
    else
      [city, country.local_name]
    end
  end

  def find_country_and_province
    if self.country_name.present?
      self.country = Country.find_by_local_name(country_name)
    end
    if self.province_name.present?
      self.province = Province.find_by_local_name(province_name)
    end
  end
end
