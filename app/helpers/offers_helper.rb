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

  def search_description(params)
    if params[:adv].present? && params[:adv] == '1'
      advanced_search_description(params)
    elsif params[:q].present?
      basic_search_description(params)
    else
      nil
    end
  end

  def reset_search_link
    link_to I18n.t('offers.search_description.reset'), offers_path
  end

  def advanced_search_description(params)
    msg = []
    key_prefix = 'offers.search_description.advanced.'
    search_params = {
      cid: -> { Country.find_by(id: params[:cid]).try(:local_name) },
      pid: -> { Province.find_by(id: params[:pid]).try(:local_name) },
      cur: -> { I18n.t('currencies.' + params[:cur]) },
      smin: -> { params[:smin] }
    }
    search_params.each do |k,v|
      if params[k].present?
        msg << I18n.t(key_prefix + k.to_s, val: v.call)
      end
    end
    if msg.empty?
      return I18n.t(key_prefix + 'all')
    end
    raw (I18n.t(key_prefix + 'start') + msg.join(I18n.t(key_prefix + 'separator')) + I18n.t(key_prefix + 'end'))
  end

  def basic_search_description(params)
    raw I18n.t('offers.search_description.basic', q: params[:q])
  end

  def short_salary(offer)
    if offer.salary.present?
      readable_currency_range(offer.salary, offer.currency) +
        I18n.t('offers.table.per_month')
    elsif offer.hourly_wage.present?
      readable_currency_range(offer.hourly_wage, offer.currency) +
        I18n.t('offers.table.per_hour')
    else
      I18n.t('currency_range.none')
    end
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
