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

ActiveRecord::Schema.define(version: 20150116155033) do

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.text     "body"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "committee_translations", force: true do |t|
    t.integer  "committee_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
  end

  add_index "committee_translations", ["committee_id"], name: "index_committee_translations_on_committee_id", using: :btree
  add_index "committee_translations", ["locale"], name: "index_committee_translations_on_locale", using: :btree

  create_table "committees", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "email"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "committees", ["slug"], name: "index_committees_on_slug", using: :btree

  create_table "configurables", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "configurables", ["name"], name: "index_configurables_on_name", using: :btree

  create_table "course_translations", force: true do |t|
    t.integer  "course_id",   null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "course_translations", ["course_id"], name: "index_course_translations_on_course_id", using: :btree
  add_index "course_translations", ["locale"], name: "index_course_translations_on_locale", using: :btree

  create_table "courses", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "year"
    t.boolean  "required"
    t.string   "homepage"
    t.string   "programme"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["code"], name: "index_courses_on_code", using: :btree

  create_table "courses_periods", id: false, force: true do |t|
    t.integer "period_id"
    t.integer "course_id"
  end

  create_table "events", force: true do |t|
    t.date    "event_date"
    t.boolean "full_day"
    t.time    "start_time"
    t.time    "end_time"
    t.string  "location"
    t.string  "organizer"
    t.integer "post_id"
    t.string  "facebook_link"
  end

  add_index "events", ["post_id"], name: "index_events_on_post_id", using: :btree

  create_table "images", force: true do |t|
    t.string   "source"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_links", force: true do |t|
    t.integer  "menu_id"
    t.string   "controller"
    t.string   "action"
    t.string   "params"
    t.string   "title"
    t.integer  "preferred_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_links", ["menu_id"], name: "index_menu_links_on_menu_id", using: :btree

  create_table "menus", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree
  add_index "pages", ["title"], name: "index_pages_on_title", using: :btree

  create_table "periods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_translations", force: true do |t|
    t.integer  "post_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.string   "slug"
  end

  add_index "post_translations", ["locale"], name: "index_post_translations_on_locale", using: :btree
  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "user_id",        limit: 20,                 null: false
    t.string   "group_id",       limit: 20
    t.string   "title",                                     null: false
    t.text     "body",                                      null: false
    t.boolean  "sticky",                    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "comments_count",            default: 0
  end

  add_index "posts", ["group_id"], name: "index_posts_on_group_id", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree
  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "printers", force: true do |t|
    t.string  "name"
    t.string  "location"
    t.string  "media"
    t.integer "weight",   default: 10
  end

end
