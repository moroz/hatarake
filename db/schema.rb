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

ActiveRecord::Schema.define(version: 20170508170817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.integer  "candidate_id"
    t.integer  "offer_id"
    t.text     "memo"
    t.boolean  "read"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["offer_id"], name: "index_applications_on_offer_id", using: :btree
  end

  create_table "avatars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_id"], name: "index_avatars_on_user_id", using: :btree
  end

  create_table "candidate_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.boolean  "looking_for_work"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "sex",              limit: 2,              comment: "ISO/IEC 5218-compliant sex field, 1 male, 2 female"
    t.index ["user_id"], name: "index_candidate_profiles_on_user_id", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string "iso"
    t.string "name_pl"
    t.string "name_en"
  end

  create_table "education_items", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "specialization"
    t.integer  "organization_id"
    t.integer  "candidate_id"
    t.string   "memo"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "category"
    t.index ["organization_id"], name: "index_education_items_on_organization_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "salary_min"
    t.integer  "salary_max"
    t.string   "currency"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "title"
    t.string   "location"
    t.integer  "country_id"
    t.boolean  "published",     default: false
    t.datetime "published_at"
    t.string   "slug"
    t.integer  "province_id"
    t.index ["company_id"], name: "index_offers_on_company_id", using: :btree
    t.index ["country_id"], name: "index_offers_on_country_id", using: :btree
    t.index ["province_id"], name: "index_offers_on_province_id", using: :btree
    t.index ["slug"], name: "index_offers_on_slug", unique: true, using: :btree
  end

  create_table "offers_skills", id: false, force: :cascade do |t|
    t.integer "offer_id", null: false
    t.integer "skill_id", null: false
    t.index ["offer_id"], name: "index_offers_skills_on_offer_id", using: :btree
    t.index ["skill_id"], name: "index_offers_skills_on_skill_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_pl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "body_pl"
  end

  create_table "professions", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_pl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.integer "country_id"
    t.string  "name_en"
    t.string  "name_pl"
    t.index ["country_id"], name: "index_provinces_on_country_id", using: :btree
  end

  create_table "skill_items", force: :cascade do |t|
    t.integer  "level"
    t.integer  "candidate_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "skill_id"
    t.index ["candidate_id"], name: "index_skill_items_on_candidate_id", using: :btree
    t.index ["skill_id"], name: "index_skill_items_on_skill_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_pl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type"
    t.string   "name",                                             comment: "Only for Companies"
    t.integer  "profession_id"
    t.string   "slug"
    t.text     "description"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  end

  create_table "work_items", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "position"
    t.integer  "organization_id"
    t.integer  "candidate_id"
    t.string   "memo"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "category"
    t.index ["organization_id"], name: "index_work_items_on_organization_id", using: :btree
  end

  add_foreign_key "applications", "offers"
  add_foreign_key "applications", "users", column: "candidate_id"
  add_foreign_key "avatars", "users"
  add_foreign_key "candidate_profiles", "users"
  add_foreign_key "education_items", "organizations"
  add_foreign_key "education_items", "users", column: "candidate_id"
  add_foreign_key "offers", "countries"
  add_foreign_key "offers", "provinces"
  add_foreign_key "provinces", "countries"
  add_foreign_key "skill_items", "skills"
  add_foreign_key "work_items", "organizations"
  add_foreign_key "work_items", "users", column: "candidate_id"
end
