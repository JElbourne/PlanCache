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

ActiveRecord::Schema.define(version: 20150213043031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "accounts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "key"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["key"], name: "index_accounts_on_key", using: :btree

  create_table "branches", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "subject"
    t.string   "lower_subjects", default: [],              array: true
    t.uuid     "cache_id"
    t.uuid     "user_id"
    t.uuid     "account_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "branches", ["cache_id", "account_id"], name: "index_branches_on_cache_id_and_account_id", using: :btree
  add_index "branches", ["lower_subjects"], name: "index_branches_on_lower_subjects", using: :gin
  add_index "branches", ["user_id", "account_id"], name: "index_branches_on_user_id_and_account_id", using: :btree

  create_table "messages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "branch_id"
    t.uuid     "user_id"
    t.uuid     "account_id"
    t.string   "email"
    t.string   "subject"
    t.hstore   "to",                       array: true
    t.hstore   "from"
    t.hstore   "cc",                       array: true
    t.text     "body"
    t.text     "raw_text"
    t.text     "raw_html"
    t.text     "raw_body"
    t.text     "raw_headers"
    t.hstore   "headers"
    t.json     "files_json"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "messages", ["account_id", "branch_id"], name: "index_messages_on_account_id_and_branch_id", using: :btree
  add_index "messages", ["account_id", "email"], name: "index_messages_on_account_id_and_email", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "email"
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "location"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", using: :btree

end
