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

ActiveRecord::Schema.define(version: 20160625162802) do

  create_table "locations", force: :cascade do |t|
    t.string   "city",       limit: 255
    t.string   "state_prov", limit: 255
    t.string   "latitude",   limit: 255
    t.string   "longitude",  limit: 255
    t.integer  "report_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["report_id"], name: "index_locations_on_report_id", using: :btree

  create_table "locomotives", force: :cascade do |t|
    t.string   "railroad",   limit: 255
    t.string   "number",     limit: 255
    t.string   "loco_type",  limit: 255
    t.integer  "report_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locomotives", ["report_id"], name: "index_locomotives_on_report_id", using: :btree

  create_table "railroads", force: :cascade do |t|
    t.string   "railroad",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "marks",      limit: 255
  end

  create_table "reports", force: :cascade do |t|
    t.string   "username",     limit: 50
    t.string   "train_number", limit: 255
    t.string   "direction",    limit: 10
    t.string   "info",         limit: 255
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id",      limit: 255
    t.string   "rating",       limit: 255
    t.string   "timezone",     limit: 255
    t.string   "offset",       limit: 255
    t.string   "railroad",     limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                        limit: 255
    t.string   "email",                           limit: 255,                 null: false
    t.string   "crypted_password",                limit: 255
    t.string   "salt",                            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rating",                          limit: 255
    t.string   "votecount",                       limit: 255
    t.boolean  "email_confirmed",                 limit: 1,   default: false
    t.string   "confirm_token",                   limit: 255
    t.string   "reset_password_token",            limit: 255
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.string   "username",   limit: 50
    t.string   "report_id",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "locations", "reports"
  add_foreign_key "locomotives", "reports"
end
