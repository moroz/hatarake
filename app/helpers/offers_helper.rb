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
end
