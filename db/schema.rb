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

ActiveRecord::Schema.define(version: 20161123024700) do

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.boolean  "completed"
    t.string   "root"
    t.string   "http"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "branches", ["user_id"], name: "index_branches_on_user_id"

  create_table "nes", force: :cascade do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "ectype"
    t.integer  "user_id"
    t.boolean  "isonline"
    t.text     "system"
  end

  add_index "nes", ["user_id"], name: "index_nes_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "state"
    t.string   "privilege"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
