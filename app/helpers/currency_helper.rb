module CurrencyHelper
  VAT_RATE = 23
  def net_price(price)
    (price * (100.0/(100+VAT_RATE))).round(2)
  end

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
    format = if min.nil?
               if max.nil?
                 'none'
               else
                 'max'
               end
             else
               if max.nil?
                 'min'
               else
                 if min == max
                   'mineqmax'
                 else
                   'minmax'
                 end
               end
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