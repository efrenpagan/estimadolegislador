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

ActiveRecord::Schema.define(version: 20150525050708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "email_politicians", force: true do |t|
    t.integer  "email_id"
    t.integer  "politician_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "from_name"
    t.string   "from_email"
    t.string   "subject"
    t.string   "message"
    t.boolean  "is_public"
    t.string   "short_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "politicians", force: true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "description"
    t.string   "role"
    t.string   "email"
    t.string   "political_party"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

end
