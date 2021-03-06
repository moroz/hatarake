# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_13_153957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "applications", id: :serial, force: :cascade do |t|
    t.integer "candidate_id"
    t.integer "offer_id"
    t.text "memo"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_applications_on_offer_id"
  end

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.string "file"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "language"
    t.text "description"
    t.string "filename"
    t.boolean "vector", default: false
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.bigint "order_id"
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "house_no"
    t.string "apt_no"
    t.string "postal_code"
    t.string "city"
    t.string "nip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_billing_addresses_on_order_id"
  end

  create_table "blog_posts", force: :cascade do |t|
    t.bigint "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "body"], name: "index_blog_posts_on_user_id_and_body", unique: true
    t.index ["user_id"], name: "index_blog_posts_on_user_id"
  end

  create_table "candidate_profiles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.boolean "looking_for_work"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sex", limit: 2, comment: "ISO/IEC 5218-compliant\n               sex field, 1 male, 2 female"
    t.datetime "lfw_at"
    t.string "profession_name"
    t.index ["user_id"], name: "index_candidate_profiles_on_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "offer_ids"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "finalized", default: false
    t.datetime "finalized_at"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "companies_fields", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "field_id", null: false
    t.index ["company_id", "field_id"], name: "index_companies_fields_on_company_id_and_field_id"
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "iso"
    t.string "name_pl"
    t.string "name_en"
  end

  create_table "education_items", id: :serial, force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "specialization"
    t.integer "candidate_id"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "organization"
    t.integer "location_id"
    t.index ["location_id"], name: "index_education_items_on_location_id"
  end

  create_table "fields", id: :serial, force: :cascade do |t|
    t.string "name_en"
    t.string "name_pl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "imported_offers", force: :cascade do |t|
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
    t.integer "views", default: 0
    t.boolean "apply_on_website", default: false
    t.string "application_url"
    t.datetime "featured_until", comment: "Featuring on the homepage"
    t.datetime "category_until", comment: "Featuring on the category page"
    t.datetime "highlight_until", comment: "Highlight with colors"
    t.integer "req_lang_1", limit: 2
    t.integer "req_lang_2", limit: 2
    t.date "social_until"
    t.date "special_until"
    t.string "external_id"
    t.string "external_url"
    t.string "source"
    t.string "location"
    t.boolean "published", default: false
    t.string "field_name"
    t.index ["slug"], name: "index_importd_offers_on_slug", unique: true
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.integer "country_id"
    t.integer "province_id"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "offer_id"
    t.index ["country_id"], name: "index_locations_on_country_id"
    t.index ["province_id"], name: "index_locations_on_province_id"
  end

  create_table "newsletter_subscriptions", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_newsletter_subscriptions_on_email", unique: true
  end

  create_table "offer_saves", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_saves_on_offer_id"
  end

  create_table "offers", id: :serial, force: :cascade do |t|
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
    t.string "external_id"
    t.index ["company_id"], name: "index_offers_on_company_id"
    t.index ["published_at"], name: "index_offers_on_published_at"
    t.index ["req_lang_1"], name: "index_offers_on_req_lang_1"
    t.index ["req_lang_2"], name: "index_offers_on_req_lang_2"
    t.index ["slug"], name: "index_offers_on_slug", unique: true
  end

  create_table "offers_skills", id: false, force: :cascade do |t|
    t.bigint "offer_id", null: false
    t.bigint "skill_id", null: false
    t.index ["offer_id"], name: "index_offers_skills_on_offer_id"
    t.index ["skill_id"], name: "index_offers_skills_on_skill_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "cart_id"
    t.string "currency", default: "pln"
    t.string "unique_token"
    t.string "payment_status"
    t.datetime "paid_at"
    t.decimal "total", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invoice"
    t.boolean "polish_taxpayer", default: true
    t.decimal "deduction", precision: 6, scale: 2
    t.decimal "amount_due", precision: 8, scale: 2
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["unique_token"], name: "index_orders_on_unique_token", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "currency", default: "pln"
    t.string "description"
    t.string "unique_token"
    t.integer "payer_id"
    t.decimal "amount", precision: 6, scale: 2
    t.index ["description"], name: "index_payments_on_description", unique: true
    t.index ["unique_token"], name: "index_payments_on_unique_token", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name_pl"
    t.string "name_en"
    t.decimal "price_pln", precision: 8, scale: 2
    t.decimal "price_eur", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description_en"
    t.text "description_pl"
    t.string "backend_name"
    t.integer "order"
    t.index ["backend_name"], name: "index_products_on_backend_name", unique: true
  end

  create_table "provinces", id: :serial, force: :cascade do |t|
    t.integer "country_id"
    t.string "name_en"
    t.string "name_pl"
    t.index ["country_id"], name: "index_provinces_on_country_id"
  end

  create_table "skill_items", id: :serial, force: :cascade do |t|
    t.integer "level"
    t.integer "candidate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "skill_id"
    t.index ["candidate_id"], name: "index_skill_items_on_candidate_id"
    t.index ["skill_id"], name: "index_skill_items_on_skill_id"
  end

  create_table "skills", id: :serial, force: :cascade do |t|
    t.string "name_en"
    t.string "name_pl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "name", comment: "Only for Companies"
    t.string "slug"
    t.text "description"
    t.string "website"
    t.integer "location_id"
    t.string "phone"
    t.string "contact_email"
    t.string "locale"
    t.hstore "premium_services"
    t.datetime "premium_until"
    t.integer "published_offers_count", default: 0
    t.decimal "balance", precision: 8, scale: 2
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["contact_email"], name: "index_users_on_contact_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "work_items", id: :serial, force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "position"
    t.integer "candidate_id"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "organization"
    t.integer "location_id"
    t.index ["location_id"], name: "index_work_items_on_location_id"
  end

  add_foreign_key "applications", "offers"
  add_foreign_key "applications", "users", column: "candidate_id"
  add_foreign_key "attachments", "users", column: "owner_id"
  add_foreign_key "blog_posts", "users"
  add_foreign_key "candidate_profiles", "users"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "education_items", "locations"
  add_foreign_key "education_items", "users", column: "candidate_id"
  add_foreign_key "locations", "countries"
  add_foreign_key "locations", "provinces"
  add_foreign_key "offer_saves", "offers"
  add_foreign_key "offers", "fields"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "users", column: "payer_id"
  add_foreign_key "provinces", "countries"
  add_foreign_key "skill_items", "skills"
  add_foreign_key "users", "locations"
  add_foreign_key "work_items", "locations"
  add_foreign_key "work_items", "users", column: "candidate_id"
end
