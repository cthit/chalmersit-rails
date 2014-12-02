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

ActiveRecord::Schema.define(version: 20141202190444) do

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

  create_table "courses_periods", id: false, force: true do |t|
    t.integer "period_id"
    t.integer "course_id"
  end

  create_table "periods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "user_id",    limit: 20,                 null: false
    t.string   "group_id",   limit: 20
    t.string   "title",                                 null: false
    t.text     "body",                                  null: false
    t.boolean  "sticky",                default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["group_id"], name: "index_posts_on_group_id", using: :btree
  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

end
