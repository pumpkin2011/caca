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

ActiveRecord::Schema.define(version: 20150614151815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "alipays", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "alipays", ["user_id"], name: "index_alipays_on_user_id", using: :btree

  create_table "banks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "account"
    t.string   "deposit"
    t.string   "front"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "banks", ["user_id"], name: "index_banks_on_user_id", using: :btree

  create_table "bills", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "log"
    t.decimal  "amount",                precision: 10, scale: 2
    t.string   "state",      limit: 20
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "total",                 precision: 10, scale: 2
    t.string   "process",    limit: 10
  end

  add_index "bills", ["process"], name: "index_bills_on_process", using: :btree
  add_index "bills", ["state"], name: "index_bills_on_state", using: :btree
  add_index "bills", ["user_id"], name: "index_bills_on_user_id", using: :btree

  create_table "blacklists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "blacklists", ["target_id"], name: "index_blacklists_on_target_id", using: :btree
  add_index "blacklists", ["user_id"], name: "index_blacklists_on_user_id", using: :btree

  create_table "complaints", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.text     "question"
    t.text     "answer"
    t.string   "state",          limit: 10
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "task_id"
    t.string   "reason",         limit: 20
  end

  add_index "complaints", ["state"], name: "index_complaints_on_state", using: :btree
  add_index "complaints", ["target_user_id"], name: "index_complaints_on_target_user_id", using: :btree
  add_index "complaints", ["task_id"], name: "index_complaints_on_task_id", using: :btree
  add_index "complaints", ["user_id"], name: "index_complaints_on_user_id", using: :btree

  create_table "delivers", force: :cascade do |t|
    t.integer  "user_id"
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
    t.integer  "owner_id"
  end

  add_index "delivers", ["owner_id"], name: "index_delivers_on_owner_id", using: :btree
  add_index "delivers", ["state"], name: "index_delivers_on_state", using: :btree
  add_index "delivers", ["user_id"], name: "index_delivers_on_user_id", using: :btree

  create_table "deposits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "admin_id"
    t.string   "sn",         limit: 32
    t.decimal  "amount",                precision: 10, scale: 2
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "state",      limit: 10
  end

  add_index "deposits", ["admin_id"], name: "index_deposits_on_admin_id", using: :btree
  add_index "deposits", ["sn"], name: "index_deposits_on_sn", unique: true, using: :btree
  add_index "deposits", ["state"], name: "index_deposits_on_state", using: :btree
  add_index "deposits", ["user_id"], name: "index_deposits_on_user_id", using: :btree

  create_table "extracts", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount",                precision: 10, scale: 2
    t.string   "channel",    limit: 10
    t.string   "sn",         limit: 50
    t.string   "state",      limit: 10
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "extracts", ["channel"], name: "index_extracts_on_channel", using: :btree
  add_index "extracts", ["sn"], name: "index_extracts_on_sn", using: :btree
  add_index "extracts", ["state"], name: "index_extracts_on_state", using: :btree
  add_index "extracts", ["user_id"], name: "index_extracts_on_user_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "number"
    t.string   "front"
    t.string   "back"
    t.string   "handheld"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.datetime "confirmed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "invitations", ["target_id"], name: "index_invitations_on_target_id", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "wangwang_id"
    t.integer  "task_id"
    t.string   "state",       limit: 10
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "ip",          limit: 20
    t.integer  "shop_id"
  end

  add_index "orders", ["ip"], name: "index_orders_on_ip", using: :btree
  add_index "orders", ["shop_id"], name: "index_orders_on_shop_id", using: :btree
  add_index "orders", ["state"], name: "index_orders_on_state", using: :btree
  add_index "orders", ["task_id"], name: "index_orders_on_task_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree
  add_index "orders", ["wangwang_id"], name: "index_orders_on_wangwang_id", using: :btree

  create_table "page_categories", force: :cascade do |t|
    t.string   "name",       limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "pages", ["category_id"], name: "index_pages_on_category_id", using: :btree

  create_table "pictrues", force: :cascade do |t|
    t.string   "url"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "shops", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "account",    limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "state",      limit: 10
  end

  add_index "shops", ["state"], name: "index_shops_on_state", using: :btree
  add_index "shops", ["user_id"], name: "index_shops_on_user_id", using: :btree

  create_table "task_autos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "template_id"
    t.string   "state",         limit: 10
    t.integer  "interval"
    t.integer  "total_count"
    t.integer  "process_count",            default: 0
    t.integer  "faild_count",              default: 0
    t.datetime "next_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "task_autos", ["state"], name: "index_task_autos_on_state", using: :btree
  add_index "task_autos", ["template_id"], name: "index_task_autos_on_template_id", using: :btree
  add_index "task_autos", ["user_id"], name: "index_task_autos_on_user_id", using: :btree

  create_table "task_templates", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       limit: 20
    t.text     "content"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "available"
  end

  add_index "task_templates", ["user_id"], name: "index_task_templates_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "shop_id"
    t.string   "link"
    t.string   "keywords"
    t.decimal  "price",                       precision: 10, scale: 2
    t.string   "duration",         limit: 10
    t.string   "level",            limit: 10
    t.string   "chat",             limit: 10
    t.string   "desc"
    t.string   "spec"
    t.boolean  "receive_time"
    t.boolean  "comment_time"
    t.string   "comment"
    t.string   "extra",            limit: 10
    t.string   "state",            limit: 10
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.decimal  "commission",                  precision: 10, scale: 2
    t.decimal  "commission_extra",            precision: 10, scale: 2
    t.string   "task_type",        limit: 10
    t.string   "cover"
    t.integer  "producer_id"
    t.integer  "consumer_id"
    t.integer  "wangwang_id"
    t.string   "ip",               limit: 20
    t.string   "code",             limit: 20
  end

  add_index "tasks", ["code"], name: "index_tasks_on_code", using: :btree
  add_index "tasks", ["consumer_id"], name: "index_tasks_on_consumer_id", using: :btree
  add_index "tasks", ["duration"], name: "index_tasks_on_duration", using: :btree
  add_index "tasks", ["extra"], name: "index_tasks_on_extra", using: :btree
  add_index "tasks", ["ip"], name: "index_tasks_on_ip", using: :btree
  add_index "tasks", ["level"], name: "index_tasks_on_level", using: :btree
  add_index "tasks", ["producer_id"], name: "index_tasks_on_producer_id", using: :btree
  add_index "tasks", ["shop_id"], name: "index_tasks_on_shop_id", using: :btree
  add_index "tasks", ["state"], name: "index_tasks_on_state", using: :btree
  add_index "tasks", ["task_type"], name: "index_tasks_on_task_type", using: :btree
  add_index "tasks", ["wangwang_id"], name: "index_tasks_on_wangwang_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                      default: "",  null: false
    t.string   "encrypted_password",                                         default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                              default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",                            precision: 10, scale: 2, default: 0.0
    t.decimal  "frozen_amount",                     precision: 10, scale: 2, default: 0.0
    t.string   "name",                   limit: 20
    t.string   "qq",                     limit: 15
    t.string   "state",                  limit: 10
    t.string   "referral_token"
    t.integer  "failed_attempts",                                            default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "vip_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["qq"], name: "index_users_on_qq", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["state"], name: "index_users_on_state", using: :btree

  create_table "vips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pricing"
    t.boolean  "largess",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "vips", ["user_id"], name: "index_vips_on_user_id", using: :btree

  create_table "wangwangs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "account",    limit: 50
    t.string   "state",      limit: 10
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "wangwangs", ["state"], name: "index_wangwangs_on_state", using: :btree
  add_index "wangwangs", ["user_id"], name: "index_wangwangs_on_user_id", using: :btree

  add_foreign_key "alipays", "users"
  add_foreign_key "banks", "users"
  add_foreign_key "bills", "users"
  add_foreign_key "complaints", "tasks"
  add_foreign_key "complaints", "users"
  add_foreign_key "delivers", "users"
  add_foreign_key "delivers", "users", column: "owner_id"
  add_foreign_key "deposits", "admins"
  add_foreign_key "deposits", "users"
  add_foreign_key "extracts", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "orders", "shops"
  add_foreign_key "orders", "tasks"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "wangwangs"
  add_foreign_key "shops", "users"
  add_foreign_key "task_templates", "users"
  add_foreign_key "tasks", "shops"
  add_foreign_key "vips", "users"
  add_foreign_key "wangwangs", "users"
end
