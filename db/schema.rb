# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160714134625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "indicator_configs", force: :cascade do |t|
    t.string   "agency",                       default: ""
    t.string   "contact_email",                default: ""
    t.string   "contact_name",                 default: ""
    t.string   "contact_phone",                default: ""
    t.string   "desired_direction",            default: ""
    t.string   "display_units",                default: ""
    t.string   "frequency",                    default: ""
    t.float    "full_green_percent"
    t.string   "geog_type1"
    t.string   "geog_type2"
    t.boolean  "has_historical_geo"
    t.boolean  "has_previous_fytd_geo"
    t.boolean  "has_previous_geo"
    t.boolean  "has_previous_year_period_geo"
    t.string   "indicator_id",                 default: ""
    t.string   "indicator_name",               default: ""
    t.text     "indicator_description",        default: ""
    t.string   "interest_t",                   default: ""
    t.string   "measure_t",                    default: ""
    t.float    "neutral_full_green"
    t.boolean  "neutral_indicator"
    t.boolean  "real"
    t.string   "recording_units",              default: ""
    t.boolean  "visible"
    t.string   "ytd_type",                     default: ""
    t.boolean  "zero_tolerance"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "cartodb_id"
    t.integer  "sync_state"
    t.integer  "increase_threshold"
    t.integer  "decrease_threshold"
  end

  create_table "mail_notifications", force: :cascade do |t|
    t.datetime "sent_at"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mail_notifications", ["status"], name: "index_mail_notifications_on_status", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "indicator_config_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "is_threshold_subscription", default: false
  end

  add_index "subscriptions", ["indicator_config_id"], name: "index_subscriptions_on_indicator_config_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "synchronizations", force: :cascade do |t|
    t.datetime "date"
    t.string   "status"
    t.string   "sync_id"
    t.text     "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "sync_at"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "uid"
    t.string   "cdb_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  create_table "value_objects", force: :cascade do |t|
    t.string   "data_set_name"
    t.string   "geo_type"
    t.integer  "geo_id"
    t.float    "current_val"
    t.float    "previous_val"
    t.float    "current_fytd"
    t.float    "previous_fytd"
    t.float    "previous_year_period"
    t.string   "uid"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "as_of_dt"
    t.date     "created_dt"
  end

  add_index "value_objects", ["uid"], name: "index_value_objects_on_uid", unique: true, using: :btree

end
