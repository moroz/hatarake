module OffersHelper
  def localized_collection(collection, value = nil)
    options_from_collection_for_select(collection, :id, local_name, value)
  end
end
