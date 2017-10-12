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

ActiveRecord::Schema.define(version: 20170217093009) do

  create_table "admin_catalogues", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "parent"
    t.integer  "order"
    t.integer  "level"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.string   "content"
    t.integer  "status"
    t.string   "node"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogue2", force: :cascade do |t|
    t.integer  "level"
    t.string   "name"
    t.string   "image"
    t.string   "parent"
    t.string   "slug"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogues", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "parent"
    t.integer  "order"
    t.integer  "level"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "productid"
    t.integer  "userid"
    t.string   "title"
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "finalprice"
    t.string   "description"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "options", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.string   "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "status"
    t.string   "sub"
    t.string   "slug"
    t.string   "description"
    t.string   "keywords"
    t.string   "custom_field"
    t.string   "show_type"
    t.string   "template"
    t.integer  "order"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "image"
    t.string   "title"
    t.string   "description"
    t.string   "intro"
    t.string   "content"
    t.string   "webtype"
    t.integer  "orders"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.string   "image"
    t.integer  "quantity"
    t.integer  "price"
    t.string   "description"
    t.integer  "status"
    t.string   "node"
    t.integer  "order"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "value"
    t.string   "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sqlite_stat1", id: false, force: :cascade do |t|
    t. "tbl"
    t. "idx"
    t. "stat"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.string   "address"
    t.string   "contact"
    t.string   "company"
    t.integer  "status"
    t.integer  "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
