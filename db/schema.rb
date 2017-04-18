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

ActiveRecord::Schema.define(version: 20170418061954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "cv_items", force: :cascade do |t|
    t.string   "category"
    t.string   "position"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "organization_id"
    t.integer  "candidate_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["candidate_id"], name: "index_cv_items_on_candidate_id", using: :btree
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "salary_min"
    t.integer  "salary_max"
    t.string   "currency"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
    t.string   "location"
    t.index ["company_id"], name: "index_offers_on_company_id", using: :btree
  end

  create_table "offers_skills", id: false, force: :cascade do |t|
    t.integer "offer_id", null: false
    t.integer "skill_id", null: false
    t.index ["offer_id"], name: "index_offers_skills_on_offer_id", using: :btree
    t.index ["skill_id"], name: "index_offers_skills_on_skill_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "name_pl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_items", force: :cascade do |t|
    t.string   "level"
    t.integer  "candidate_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "skill_id"
    t.index ["candidate_id"], name: "index_skill_items_on_candidate_id", using: :btree
    t.index ["skill_id"], name: "index_skill_items_on_skill_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
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
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.string   "name",                                             comment: "Only for Companies"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "avatars", "users"
  add_foreign_key "skill_items", "skills"
end
