# frozen_string_literal: true

module AutocompleteHelper
  def highlight_search_term(str, term, highlight_class: 'ui-state-highlight')
    regex = Regexp.new("(#{term})", Regexp::IGNORECASE)
    str.sub(regex, "<span class='#{highlight_class}'>#{term}</span>")
  end

  def highlight_search_term_in_collection(collection, term, highlight_class: 'ui-state-highlight')
    collection.map do |item|
      {
        label: highlight_search_term(item, term, highlight_class: highlight_class),
        value: item
      }
    end
  end
end
