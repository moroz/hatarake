class Skill < ApplicationRecord
  has_many :skill_items
  has_and_belongs_to_many :offers
  validates :name, uniqueness: true, presence: true
  validates :name_pl, uniqueness: true
  extend FindOrCreate

  def self.search(q)
    where("name ILIKE :q OR name_pl ILIKE :q", q: "%" + sanitize_sql_like(q) + "%")
  end

  def self.serialize_for_autocomplete(label_method: "name", value_method: "name")
    all.map { |s| {id: s.id, label: s[label_method], value: s[value_method]} }
  end
end
