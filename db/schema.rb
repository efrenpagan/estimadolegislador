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

ActiveRecord::Schema.define(version: 20141217035408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "districts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legislators", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "representatives", force: true do |t|
    t.integer  "district_id"
    t.integer  "legislator_id", null: false
    t.integer  "category",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "representatives", ["legislator_id"], name: "index_representatives_on_legislator_id", using: :btree

  create_table "senators", force: true do |t|
    t.integer  "district_id"
    t.integer  "legislator_id", null: false
    t.integer  "category",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "senators", ["legislator_id"], name: "index_senators_on_legislator_id", using: :btree

end
