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

ActiveRecord::Schema.define(version: 20140920055645) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "food_type"
    t.string   "location"
    t.datetime "start_time"
    t.integer  "quantity"
    t.string   "quality"
    t.integer  "awkwardness"
    t.string   "wait_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "university"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "votes", force: true do |t|
    t.integer  "event_id"
    t.boolean  "exists"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
