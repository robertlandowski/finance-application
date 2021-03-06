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

ActiveRecord::Schema.define(version: 20171224053227) do

  create_table "budgetevents", force: :cascade do |t|
    t.string   "title"
    t.integer  "value"
    t.boolean  "recurring"
    t.integer  "recurringtime"
    t.boolean  "duplicated"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  add_index "budgetevents", ["user_id"], name: "index_budgetevents_on_user_id"

  create_table "budgets", force: :cascade do |t|
    t.integer  "yearly"
    t.integer  "monthly"
    t.integer  "weekly"
    t.integer  "daily"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "budgets", ["user_id"], name: "index_budgets_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.integer  "value"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.boolean  "recurring"
    t.integer  "recurringtime"
    t.boolean  "duplicated",    default: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "goals", force: :cascade do |t|
    t.integer  "yearly"
    t.integer  "monthly"
    t.integer  "weekly"
    t.integer  "daily"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "goals", ["user_id"], name: "index_goals_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id"
    t.integer  "user_id"
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.boolean  "public",      default: true
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "role"
    t.string   "name"
    t.boolean  "display",                default: true
    t.string   "timezone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
