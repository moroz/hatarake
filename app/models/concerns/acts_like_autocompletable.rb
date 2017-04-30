module ActsLikeAutocompletable
  extend ActiveSupport::Concern

  class_methods do 
    def search(q)
      where("name_en ILIKE :q OR name_pl ILIKE :q", q: "%" + sanitize_sql_like(q) + "%")
    end

    def serialize_for_autocomplete(label_method: "name_en", value_method: "name_#{I18n.locale}")
      all.map { |s| {id: s.id, label: s[label_method], value: s[value_method]} }
    end
  end
end
