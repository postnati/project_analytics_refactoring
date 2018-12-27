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

ActiveRecord::Schema.define(version: 20170913134926) do

  create_table "dev_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "effort_bucket_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "effort_buckets", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "project_id",             limit: 4
    t.integer  "effort_bucket_group_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "effort_buckets", ["effort_bucket_group_id"], name: "fk_rails_87b5103f0b", using: :btree
  add_index "effort_buckets", ["project_id"], name: "fk_rails_af38c2ea16", using: :btree

  create_table "effort_entries", force: :cascade do |t|
    t.decimal  "effort",                     precision: 10
    t.integer  "team_member_id",   limit: 4
    t.integer  "effort_bucket_id", limit: 4
    t.integer  "effort_week_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "effort_entries", ["effort_bucket_id"], name: "fk_rails_6a8acd3dab", using: :btree
  add_index "effort_entries", ["effort_week_id"], name: "fk_rails_ba0caa06bb", using: :btree
  add_index "effort_entries", ["team_member_id"], name: "fk_rails_cf1ff4c870", using: :btree

  create_table "effort_weeks", force: :cascade do |t|
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locales", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "dev_category_id", limit: 4
    t.string   "name",            limit: 255
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["dev_category_id"], name: "fk_rails_74946a3f1a", using: :btree

  create_table "resource_assignments", force: :cascade do |t|
    t.integer  "team_member_id",    limit: 4
    t.integer  "resource_group_id", limit: 4
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_assignments", ["resource_group_id"], name: "fk_rails_cec763b3e4", using: :btree
  add_index "resource_assignments", ["team_member_id"], name: "fk_rails_498e4aacb7", using: :btree

  create_table "resource_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.integer  "locale_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_members", ["locale_id"], name: "fk_rails_f3fc047a5d", using: :btree

  add_foreign_key "effort_buckets", "effort_bucket_groups"
  add_foreign_key "effort_buckets", "projects"
  add_foreign_key "effort_entries", "effort_buckets"
  add_foreign_key "effort_entries", "effort_weeks"
  add_foreign_key "effort_entries", "team_members"
  add_foreign_key "projects", "dev_categories"
  add_foreign_key "resource_assignments", "resource_groups"
  add_foreign_key "resource_assignments", "team_members"
  add_foreign_key "team_members", "locales"
end
