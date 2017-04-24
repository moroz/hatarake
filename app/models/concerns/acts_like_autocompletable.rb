module ActsLikeAutocompletable
  extend ActiveSupport::Concern

  def search(q)
    where("name ILIKE :q OR name_pl ILIKE :q", q: "%" + sanitize_sql_like(q) + "%")
  end

  def serialize_for_autocomplete(label_method: "name", value_method: "name")
    all.map { |s| {id: s.id, label: s[label_method], value: s[value_method]} }
  end

end
