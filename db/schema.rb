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

ActiveRecord::Schema.define(version: 20150704082906) do

  create_table "alerts", force: :cascade do |t|
    t.string   "message",    limit: 255
    t.integer  "group_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "sent",       limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "contact_type", limit: 4
    t.string   "value",        limit: 255
    t.boolean  "visible",      limit: 1,   default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "deactivations", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.text     "reason",         limit: 65535
    t.date     "effective_date"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "group_type",  limit: 4
    t.text     "photo_url",   limit: 65535
    t.boolean  "active",      limit: 1,     default: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "member_groups", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "admin",      limit: 1, default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "full_name",   limit: 255
    t.date     "dob"
    t.string   "epic_no",     limit: 255
    t.string   "birth_place", limit: 255
    t.boolean  "active",      limit: 1,     default: true
    t.string   "sex",         limit: 255
    t.text     "photo_url",   limit: 65535
    t.text     "occupation",  limit: 65535
    t.text     "address",     limit: 65535
    t.boolean  "verified",    limit: 1,     default: false
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "members", ["epic_no"], name: "index_members_on_epic_no", unique: true, using: :btree
  add_index "members", ["full_name"], name: "index_members_on_full_name", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "content",        limit: 65535
    t.integer  "post_type",      limit: 4
    t.datetime "expires_at"
    t.text     "attachment_url", limit: 65535
    t.integer  "group_id",       limit: 4
    t.integer  "user_id",        limit: 4
    t.boolean  "public",         limit: 1
    t.integer  "approved_by",    limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "message",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "level",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "system_data", force: :cascade do |t|
    t.text     "content",          limit: 65535
    t.string   "key_word",         limit: 255
    t.integer  "system_data_type", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.integer  "role_id",                limit: 4,   default: 4
    t.boolean  "deactivated",            limit: 1,   default: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
