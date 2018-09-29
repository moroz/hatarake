# frozen_string_literal: true

module CurrencyHelper
  def low_bound(range)
    pretty_currency_value range.try(:first)
  end

  def high_bound(range)
    pretty_currency_value range.try(:last)
  end

  def readable_currency_range(range, currency)
    return I18n.t('currency_range.none') if range.blank?
    min = localized_currency_value(range.first)
    max = localized_currency_value(range.last)
    puts "#{min} and #{max}"
    format = if min.nil? && max.nil? then 'none'
             elsif min.nil? && !max.nil? then 'max'
             elsif !min.nil? && max.nil? then 'min'
             elsif min == max then 'mineqmax'
             elsif min != max then 'minmax'
             end
    I18n.t("currency_range.#{format}", min: min, max: max, currency: currency.upcase)
  end

  def localized_currency_value(value)
    return if value.nil?
    value.infinite? ? nil : number_with_precision(value, strip_insignificant_zeros: true, precision: 2)
  end

  def pretty_currency_value(value)
    return if value.nil?
    value.infinite? ? nil : number_with_precision(value, separator: '.', strip_insignificant_zeros: true, precision: 2)
  end
end
