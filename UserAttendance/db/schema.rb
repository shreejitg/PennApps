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

ActiveRecord::Schema.define(version: 20150117201013) do

  create_table "groups", force: :cascade do |t|
    t.string  "name",                       limit: 255
    t.string  "lattitude",                  limit: 255
    t.string  "longitude",                  limit: 255
    t.integer "reqd_duration_in_secs",      limit: 8
    t.integer "attendance_reqd_percentage", limit: 4
  end

  create_table "location_logs", force: :cascade do |t|
    t.string   "lattitude",  limit: 255
    t.string   "longitude",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.string  "role",     limit: 255
    t.integer "group_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string "name",     limit: 255
    t.string "password", limit: 255
  end

end
