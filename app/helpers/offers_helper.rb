module OffersHelper
  def localized_collection(collection, value = nil, blank: nil)
    str = ""
    if blank.present?
      str = content_tag :option, blank, value: ""
    end
    str << options_from_collection_for_select(collection, :id, local_name, value)
    raw str
  end
end
