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

ActiveRecord::Schema.define(version: 20150702205539) do

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.text     "body",       limit: 65535
    t.string   "user_id",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "committee_translations", force: :cascade do |t|
    t.integer  "committee_id", limit: 4,     null: false
    t.string   "locale",       limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",        limit: 255
    t.text     "description",  limit: 65535
  end

  add_index "committee_translations", ["committee_id"], name: "index_committee_translations_on_committee_id", using: :btree
  add_index "committee_translations", ["locale"], name: "index_committee_translations_on_locale", using: :btree

  create_table "committees", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "url",         limit: 255
    t.string   "email",       limit: 255
    t.string   "slug",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "committees", ["slug"], name: "index_committees_on_slug", using: :btree

  create_table "configurables", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurables", ["name"], name: "index_configurables_on_name", using: :btree

  create_table "course_translations", force: :cascade do |t|
    t.integer  "course_id",   limit: 4,     null: false
    t.string   "locale",      limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
  end

  add_index "course_translations", ["course_id"], name: "index_course_translations_on_course_id", using: :btree
  add_index "course_translations", ["locale"], name: "index_course_translations_on_locale", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.string   "name",        limit: 255
    t.integer  "year",        limit: 4
    t.boolean  "required"
    t.string   "homepage",    limit: 255
    t.string   "programme",   limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["code"], name: "index_courses_on_code", using: :btree

  create_table "courses_periods", id: false, force: :cascade do |t|
    t.integer "period_id", limit: 4
    t.integer "course_id", limit: 4
  end

  create_table "events", force: :cascade do |t|
    t.date    "event_date"
    t.boolean "full_day"
    t.time    "start_time"
    t.time    "end_time"
    t.string  "location",      limit: 255
    t.string  "organizer",     limit: 255
    t.integer "post_id",       limit: 4
    t.string  "facebook_link", limit: 255
  end

  add_index "events", ["post_id"], name: "index_events_on_post_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "source",     limit: 255
    t.string   "user_id",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_links", force: :cascade do |t|
    t.integer  "menu_id",         limit: 4
    t.string   "controller",      limit: 255
    t.string   "action",          limit: 255
    t.text     "params",          limit: 65535
    t.string   "title",           limit: 255
    t.integer  "preferred_order", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_links", ["menu_id"], name: "index_menu_links_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",  limit: 4
  end

  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree
  add_index "pages", ["title"], name: "index_pages_on_title", using: :btree

  create_table "periods", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_translations", force: :cascade do |t|
    t.integer  "post_id",    limit: 4,     null: false
    t.string   "locale",     limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.string   "slug",       limit: 255
  end

  add_index "post_translations", ["locale"], name: "index_post_translations_on_locale", using: :btree
  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "user_id",        limit: 20,                    null: false
    t.string   "group_id",       limit: 20
    t.string   "title",          limit: 255
    t.text     "body",           limit: 65535
    t.boolean  "sticky",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",           limit: 255
    t.integer  "comments_count", limit: 4,     default: 0
    t.boolean  "show_public"
  end

  add_index "posts", ["group_id"], name: "index_posts_on_group_id", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree
  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "printers", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.string  "location", limit: 255
    t.string  "media",    limit: 255
    t.integer "weight",   limit: 4,   default: 10
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "provider",   limit: 255
    t.string   "token",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
