class Skill < ApplicationRecord
  has_many :skill_items
  has_and_belongs_to_many :offers
  extend FindOrCreate

  def self.search(q)
    where("name LIKE :q OR name_pl LIKE :q", q: "%" + sanitize_sql_like(q) + "%")
  end
end
