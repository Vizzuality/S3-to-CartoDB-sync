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

ActiveRecord::Schema.define(version: 20160427193854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "value_objects", force: :cascade do |t|
    t.string   "data_set_name"
    t.string   "geo_type"
    t.integer  "geo_id"
    t.integer  "current_val"
    t.integer  "previous_val"
    t.integer  "current_fytd"
    t.integer  "previous_fytd"
    t.integer  "previous_year_period"
    t.string   "uid"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "as_of_dt"
    t.date     "created_dt"
  end

  add_index "value_objects", ["uid"], name: "index_value_objects_on_uid", unique: true, using: :btree

end
