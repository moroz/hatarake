module OffersHelper
  def localized_collection(collection, value = nil, blank: nil)
    str = ""
    if blank.present?
      str = content_tag :option, blank, value: ""
    end
    value ||= collection.first.id if collection.any?
    str << options_from_collection_for_select(collection, :id, local_name, value)
    raw str
  end

  def pretty_currency_value(value)
    return if value.nil?
    value.infinite? ? nil : number_with_precision(value, separator: '.', strip_insignificant_zeros: true, precision: 2)
  end

  def localized_currency_value(value)
    return if value.nil?
    value.infinite? ? nil : number_with_precision(value, strip_insignificant_zeros: true, precision: 2)
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

  def low_bound(range)
    pretty_currency_value range.try(:first)
  end

  def high_bound(range)
    pretty_currency_value range.try(:last)
  end
end
