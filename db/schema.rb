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

ActiveRecord::Schema.define(version: 20190809133551) do

  create_table "banners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "image"
    t.string   "group_id",   limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "post_id"
    t.text     "body",       limit: 65535
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
  end

  create_table "committee_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "committee_id",               null: false
    t.string   "locale",                     null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "title"
    t.text     "description",  limit: 65535
    t.index ["committee_id"], name: "index_committee_translations_on_committee_id", using: :btree
    t.index ["locale"], name: "index_committee_translations_on_locale", using: :btree
  end

  create_table "committees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description", limit: 65535
    t.string   "url"
    t.string   "email"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["slug"], name: "index_committees_on_slug", using: :btree
  end

  create_table "configurables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_configurables_on_name", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.text     "title",      limit: 65535
    t.text     "body",       limit: 65535
    t.string   "email"
    t.text     "to_whom",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "value",      limit: 65535
  end

  create_table "course_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "course_id",                 null: false
    t.string   "locale",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.text     "description", limit: 65535
    t.index ["course_id"], name: "index_course_translations_on_course_id", using: :btree
    t.index ["locale"], name: "index_course_translations_on_locale", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.date    "event_date"
    t.boolean "full_day"
    t.time    "start_time"
    t.time    "end_time"
    t.string  "location"
    t.string  "organizer"
    t.integer "post_id"
    t.string  "facebook_link"
    t.index ["post_id"], name: "index_events_on_post_id", using: :btree
  end

  create_table "frontpages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_frontpages_on_page_id", using: :btree
  end

  create_table "menu_links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "menu_id"
    t.string   "controller"
    t.string   "action"
    t.text     "params",          limit: 65535
    t.string   "title"
    t.integer  "preferred_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["menu_id"], name: "index_menu_links_on_menu_id", using: :btree
  end

  create_table "menus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "page_id",                  null: false
    t.string   "locale",                   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "title"
    t.text     "body",       limit: 65535
    t.index ["locale"], name: "index_page_translations_on_locale", using: :btree
    t.index ["page_id"], name: "index_page_translations_on_page_id", using: :btree
  end

  create_table "pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title"
    t.text     "body",       limit: 65535
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.index ["parent_id"], name: "index_pages_on_parent_id", using: :btree
    t.index ["slug"], name: "index_pages_on_slug", using: :btree
    t.index ["title"], name: "index_pages_on_title", using: :btree
  end

  create_table "post_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "post_id",                  null: false
    t.string   "locale",                   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "title"
    t.text     "body",       limit: 65535
    t.string   "slug"
    t.index ["locale"], name: "index_post_translations_on_locale", using: :btree
    t.index ["post_id"], name: "index_post_translations_on_post_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "user_id",        limit: 20,                    null: false
    t.string   "group_id",       limit: 20
    t.string   "title"
    t.text     "body",           limit: 65535
    t.boolean  "sticky",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "comments_count",               default: 0
    t.boolean  "show_public"
    t.index ["group_id"], name: "index_posts_on_group_id", using: :btree
    t.index ["slug"], name: "index_posts_on_slug", using: :btree
    t.index ["title"], name: "index_posts_on_title", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "uid"
    t.string   "provider"
    t.text     "token",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider"], name: "index_sessions_on_provider", using: :btree
    t.index ["uid"], name: "index_sessions_on_uid", using: :btree
  end

  create_table "sponsor_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "sponsor_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.index ["locale"], name: "index_sponsor_translations_on_locale", using: :btree
    t.index ["sponsor_id"], name: "index_sponsor_translations_on_sponsor_id", using: :btree
  end

  create_table "sponsors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "order"
  end

  create_table "uploads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "source"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_group_info_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_group_info_id", null: false
    t.string   "locale",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "body"
    t.index ["locale"], name: "index_user_group_info_translations_on_locale", using: :btree
    t.index ["user_group_info_id"], name: "index_user_group_info_translations_on_user_group_info_id", using: :btree
  end

  create_table "user_group_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "user_id",    limit: 20
    t.string   "group_id",   limit: 20
    t.string   "body"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

end
