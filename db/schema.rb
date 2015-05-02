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

ActiveRecord::Schema.define(version: 20150502120927) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",               limit: 255, default: "", null: false
    t.string   "encrypted_password",  limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "banks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "account",    limit: 255
    t.string   "deposit",    limit: 255
    t.string   "front",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "banks", ["user_id"], name: "index_banks_on_user_id", using: :btree

  create_table "delivers", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "owner_id",   limit: 4
    t.string   "name",       limit: 20,  null: false
    t.string   "phone",      limit: 20,  null: false
    t.string   "province",   limit: 6,   null: false
    t.string   "city",       limit: 6,   null: false
    t.string   "district",   limit: 6,   null: false
    t.string   "town",       limit: 50
    t.string   "address",    limit: 100, null: false
    t.string   "zip",        limit: 6
    t.string   "state",      limit: 10,  null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "delivers", ["owner_id"], name: "index_delivers_on_owner_id", using: :btree
  add_index "delivers", ["state"], name: "index_delivers_on_state", using: :btree
  add_index "delivers", ["user_id"], name: "index_delivers_on_user_id", using: :btree

  create_table "deposits", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "admin_id",   limit: 4
    t.string   "sn",         limit: 32
    t.decimal  "amount",                precision: 10, scale: 2
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "deposits", ["admin_id"], name: "index_deposits_on_admin_id", using: :btree
  add_index "deposits", ["sn"], name: "index_deposits_on_sn", unique: true, using: :btree
  add_index "deposits", ["user_id"], name: "index_deposits_on_user_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "number",     limit: 255
    t.string   "front",      limit: 255
    t.string   "back",       limit: 255
    t.string   "handheld",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "wangwang_id", limit: 4
    t.integer  "task_id",     limit: 4
    t.string   "state",       limit: 10
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "orders", ["state"], name: "index_orders_on_state", using: :btree
  add_index "orders", ["task_id"], name: "index_orders_on_task_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree
  add_index "orders", ["wangwang_id"], name: "index_orders_on_wangwang_id", using: :btree

  create_table "shops", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "account",    limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "state",      limit: 10
  end

  add_index "shops", ["state"], name: "index_shops_on_state", using: :btree
  add_index "shops", ["user_id"], name: "index_shops_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "shop_id",          limit: 4
    t.string   "link",             limit: 255
    t.string   "keywords",         limit: 255
    t.decimal  "price",                        precision: 10, scale: 2
    t.string   "duration",         limit: 10
    t.string   "level",            limit: 10
    t.string   "chat",             limit: 10
    t.string   "desc",             limit: 255
    t.string   "spec",             limit: 255
    t.boolean  "receive_time",     limit: 1
    t.boolean  "comment_time",     limit: 1
    t.string   "comment",          limit: 255
    t.string   "extra",            limit: 10
    t.string   "state",            limit: 10
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.decimal  "commission",                   precision: 10, scale: 2
    t.decimal  "commission_extra",             precision: 10, scale: 2
    t.string   "task_type",        limit: 10
  end

  add_index "tasks", ["duration"], name: "index_tasks_on_duration", using: :btree
  add_index "tasks", ["extra"], name: "index_tasks_on_extra", using: :btree
  add_index "tasks", ["level"], name: "index_tasks_on_level", using: :btree
  add_index "tasks", ["shop_id"], name: "index_tasks_on_shop_id", using: :btree
  add_index "tasks", ["state"], name: "index_tasks_on_state", using: :btree
  add_index "tasks", ["task_type"], name: "index_tasks_on_task_type", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                          default: "",  null: false
    t.string   "name",                   limit: 20
    t.string   "qq",                     limit: 15
    t.decimal  "amount",                             precision: 10, scale: 2, default: 0.0
    t.decimal  "frozen_amount",                      precision: 10, scale: 2, default: 0.0
    t.string   "encrypted_password",     limit: 255,                          default: "",  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,                            default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                  limit: 10
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["qq"], name: "index_users_on_qq", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["state"], name: "index_users_on_state", using: :btree

  create_table "wangwangs", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "account",    limit: 50
    t.string   "state",      limit: 10
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "wangwangs", ["state"], name: "index_wangwangs_on_state", using: :btree
  add_index "wangwangs", ["user_id"], name: "index_wangwangs_on_user_id", using: :btree

  add_foreign_key "banks", "users"
  add_foreign_key "delivers", "users"
  add_foreign_key "delivers", "users", column: "owner_id"
  add_foreign_key "deposits", "admins"
  add_foreign_key "deposits", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "orders", "tasks"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "wangwangs"
  add_foreign_key "shops", "users"
  add_foreign_key "tasks", "shops"
  add_foreign_key "tasks", "users"
  add_foreign_key "wangwangs", "users"
end
