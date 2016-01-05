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

ActiveRecord::Schema.define(version: 20160104222300) do

  create_table "reports", force: :cascade do |t|
    t.string   "username",    limit: 50
    t.string   "trainnumber", limit: 10
    t.string   "loconumber",  limit: 10
    t.string   "locotype",    limit: 20
    t.string   "railroad",    limit: 50
    t.string   "location",    limit: 30
    t.string   "direction",   limit: 10
    t.string   "additional",  limit: 255
    t.string   "info",        limit: 255
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id",     limit: 255
    t.string   "rating",      limit: 255
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

end
