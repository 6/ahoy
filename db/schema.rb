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

ActiveRecord::Schema.define(version: 20150310023149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizations", force: :cascade do |t|
    t.string "name",               null: false
    t.string "twilio_account_sid", null: false
    t.string "twilio_auth_token",  null: false
  end

  create_table "user_organizations", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "organization_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "user_organizations", ["user_id", "organization_id"], name: "index_user_organizations_on_user_id_and_organization_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "given_name",       null: false
    t.string   "surname",          null: false
    t.string   "email",            null: false
    t.string   "provider",         null: false
    t.string   "uid",              null: false
    t.string   "oauth_token",      null: false
    t.datetime "oauth_expires_at", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
