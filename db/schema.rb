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

ActiveRecord::Schema.define(version: 20151201014911) do

  create_table "reports", force: true do |t|
    t.string   "username",    limit: 50
    t.string   "trainnumber", limit: 10
    t.string   "loconumber",  limit: 10
    t.string   "locotype",    limit: 20
    t.string   "railroad",    limit: 50
    t.string   "location",    limit: 30
    t.string   "direction",   limit: 10
    t.string   "additional"
    t.string   "info"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "rating"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rating"
    t.string   "votecount"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.string   "username",   limit: 50
    t.string   "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
