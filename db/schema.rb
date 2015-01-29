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

ActiveRecord::Schema.define(version: 20150129081037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "request", force: :cascade do |t|
    t.datetime "time_begin",                      null: false
    t.datetime "time_end"
    t.string   "source_ip"
    t.integer  "service_id",                      null: false
    t.integer  "request_type_id", default: 1000
    t.integer  "session_id"
    t.string   "user_name"
    t.boolean  "is_monitoring",   default: false, null: false
    t.integer  "result_code_id"
    t.integer  "user_id"
  end

  create_table "request_type", force: :cascade do |t|
    t.string  "name",       null: false
    t.integer "service_id", null: false
  end

end
