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

ActiveRecord::Schema.define(version: 20160127232713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "host_id"
    t.string   "name"
    t.datetime "datetime"
    t.float    "cost"
    t.integer  "guest_min"
    t.integer  "guest_max"
    t.string   "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_url"
  end

  add_index "activities", ["host_id"], name: "index_activities_on_host_id", using: :btree

  create_table "activity_guests", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "guest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activity_guests", ["activity_id"], name: "index_activity_guests_on_activity_id", using: :btree
  add_index "activity_guests", ["guest_id"], name: "index_activity_guests_on_guest_id", using: :btree

  create_table "activity_tags", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activity_tags", ["activity_id"], name: "index_activity_tags_on_activity_id", using: :btree
  add_index "activity_tags", ["tag_id"], name: "index_activity_tags_on_tag_id", using: :btree

  create_table "profile_tags", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profile_tags", ["profile_id"], name: "index_profile_tags_on_profile_id", using: :btree
  add_index "profile_tags", ["tag_id"], name: "index_profile_tags_on_tag_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_url"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "activities", "users", column: "host_id"
  add_foreign_key "activity_guests", "activities"
  add_foreign_key "activity_guests", "users", column: "guest_id"
  add_foreign_key "activity_tags", "activities"
  add_foreign_key "activity_tags", "tags"
  add_foreign_key "profile_tags", "profiles"
  add_foreign_key "profile_tags", "tags"
  add_foreign_key "profiles", "users"
end
