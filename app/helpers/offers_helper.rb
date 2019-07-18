# frozen_string_literal: true

module OffersHelper
  def localized_collection(collection, value = nil, blank: nil)
    str = ''
    str = content_tag :option, blank, value: '' if blank.present?
    value ||= collection.first.id if collection.any?
    str += options_from_collection_for_select(collection, :id, local_name, value)
    raw str
  end

  def search_description(params)
    if %i[cid pid smin cur fid lr].any? { |k| params.key?(k) }
      advanced_search_description(params)
    elsif params[:q].present?
      basic_search_description(params)
    end
  end

  def reset_search_link(options = {})
    link_to I18n.t('offers.search_description.reset'), request.path, options.merge(id: 'reset_search', remote: true)
  end

  def advanced_search_description(params)
    msg = []
    key_prefix = 'offers.search_description.advanced.'
    search_params = {
      cid: -> { Country.find_by(id: params[:cid])&.local_name },
      pid: -> { Province.find_by(id: params[:pid])&.local_name },
      cur: -> { I18n.t('currencies.' + params[:cur]) },
      q: -> { params[:q] },
      smin: -> { params[:smin] },
      fid: -> { Field.find(params[:fid])&.local_name },
      lr: -> { '' }
    }
    search_params.each do |k, v|
      msg << I18n.t(key_prefix + k.to_s, val: v.call) if params[k].present?
    end
    return I18n.t(key_prefix + 'all') if msg.empty?
    raw (I18n.t(key_prefix + 'start') + msg.join(I18n.t(key_prefix + 'separator')) + I18n.t(key_prefix + 'end'))
  end

  def basic_search_description(params)
    raw I18n.t('offers.search_description.basic', q: params[:q])
  end

  def xml_salary_for(offer, salary = :salary, period = ' per month')
    if offer.read_attribute(salary).present?
      readable_currency_range(offer.read_attribute(salary), offer.currency) + ' per month'
    else
      ''
    end
  end

  def short_salary(offer)
    if offer.salary.present?
      readable_currency_range(offer.salary, offer.currency) + I18n.t('offers.table.per_month')
    elsif offer.hourly_wage.present?
      readable_currency_range(offer.hourly_wage, offer.currency) + I18n.t('offers.table.per_hour')
    else
      I18n.t('currency_range.none')
    end
  end

  def salary_and_wage_for(offer)
    a = []
    if offer.salary.present?
      a << (readable_currency_range(offer.salary, offer.currency) + I18n.t('offers.table.per_month'))
    end
    if offer.hourly_wage.present?
      a << (readable_currency_range(offer.hourly_wage, offer.currency) + I18n.t('offers.table.per_hour'))
    end
    return I18n.t('currency_range.none') if a.empty?
    a.join('<br/>')
  end

  def salary_for(offer)
    readable_currency_range(offer.salary, offer.currency)
  end

  def application_url_for(offer)
    offer.apply_on_website? ? offer.application_url : new_offer_application_url(offer_id: offer)
  end

  def application_link_for(offer, _options = {})
    url = offer.apply_on_website? ? offer.application_url : new_offer_application_path(offer_id: offer)
    url = new_user_session_path(return_to: url) unless logged_in? || offer.apply_on_website?
    if offer.apply_on_website?
      link_to I18n.t('offers.apply_on_website'), url, class: 'button expanded dark-green-bg', target: '_blank'
    else
      link_to I18n.t('offers.apply_now'), url, class: 'button expanded'
    end
  end

  def prepare_offer_meta_description(offer, company)
    location = if offer.locations.size == 1
                 offer.locations.first.only_city_format
               else
                 offer.locations.pluck(:city).join('/')
               end
    company = company.name
    t('offers.show.meta_description', title: offer.title, company: company, location: location)
  end
end
