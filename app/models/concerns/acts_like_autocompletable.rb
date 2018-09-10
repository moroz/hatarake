# frozen_string_literal: true

module ActsLikeAutocompletable
  extend ActiveSupport::Concern

  class_methods do
    def search(query)
      where('name_en ILIKE :query OR name_pl ILIKE :query', query: '%' + sanitize_sql_like(query) + '%')
    end

    def serialize_for_autocomplete(label_method: 'name_en', value_method: "name_#{I18n.locale}")
      all.map { |s| { id: s.id, label: s[label_method], value: s[value_method] } }
    end
  end
end
