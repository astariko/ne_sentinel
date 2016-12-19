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

ActiveRecord::Schema.define(version: 20161219005638) do

  create_table "branches", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.boolean  "completed"
    t.string   "root",        limit: 255
    t.string   "http",        limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "latest_load", limit: 65535
  end

  add_index "branches", ["user_id"], name: "index_branches_on_user_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "nes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "ip",          limit: 255
    t.string   "version",     limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "ectype",      limit: 65535
    t.integer  "user_id",     limit: 4
    t.boolean  "isonline"
    t.text     "system",      limit: 65535
    t.integer  "branch_id",   limit: 4
    t.text     "branch_name", limit: 65535
    t.text     "job_status",  limit: 65535
  end

  add_index "nes", ["branch_id"], name: "index_nes_on_branch_id", using: :btree
  add_index "nes", ["user_id"], name: "index_nes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",      limit: 255
    t.string   "password",      limit: 255
    t.string   "state",         limit: 255
    t.string   "privilege",     limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "lastbranch_id", limit: 4
  end

  add_index "users", ["lastbranch_id"], name: "index_users_on_lastbranch_id", using: :btree

end
