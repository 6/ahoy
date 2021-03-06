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

ActiveRecord::Schema.define(version: 20150323134623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "customers", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.string   "phone",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "email"
  end

  add_index "customers", ["phone"], name: "index_customers_on_phone", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "organization_id",                            null: false
    t.string   "type",                                       null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "body",              limit: 160,              null: false
    t.string   "twilio_message_id"
    t.integer  "customer_id",                                null: false
    t.string   "from_phone",                                 null: false
    t.string   "to_phone",                                   null: false
    t.json     "twilio_data"
    t.integer  "sender_user_id"
    t.hstore   "delivery_statuses",             default: {}, null: false
  end

  add_index "messages", ["customer_id"], name: "index_messages_on_customer_id", using: :btree
  add_index "messages", ["sender_user_id"], name: "index_messages_on_sender_user_id", using: :btree
  add_index "messages", ["twilio_message_id"], name: "index_messages_on_twilio_message_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string "name",               null: false
    t.string "twilio_account_sid", null: false
    t.string "twilio_auth_token",  null: false
    t.string "token",              null: false
    t.string "email_domain",       null: false
    t.string "phone",              null: false
  end

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
    t.integer  "organization_id"
  end

  add_index "users", ["email", "organization_id"], name: "index_users_on_email_and_organization_id", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

end
