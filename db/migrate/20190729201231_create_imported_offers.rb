class CreateImportedOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :imported_offers do |t|
      t.integer "company_id"
      t.string "currency"
      t.string "contact_email"
      t.string "contact_phone"
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "title"
      t.datetime "published_at"
      t.string "slug"
      t.numrange "hourly_wage"
      t.numrange "salary"
      t.integer "location_id"
      t.integer "views", default: 0
      t.boolean "apply_on_website", default: false
      t.string "application_url"
      t.datetime "featured_until", comment: "Featuring on the homepage"
      t.datetime "category_until", comment: "Featuring on the category page"
      t.datetime "highlight_until", comment: "Highlight with colors"
      t.integer "req_lang_1", limit: 2
      t.integer "req_lang_2", limit: 2
      t.integer "field_id"
      t.date "social_until"
      t.date "special_until"
      t.index ["slug"], name: "index_importd_offers_on_slug", unique: true
      t.timestamps
    end
  end
end
