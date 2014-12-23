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

ActiveRecord::Schema.define(version: 20141223000638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "products_count"
  end

  add_index "companies", ["name"], name: "index_companies_on_name", using: :btree

  create_table "imports", force: true do |t|
    t.integer  "items_created"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pesticides", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pesticides", ["name"], name: "index_pesticides_on_name", using: :btree

  create_table "problems", force: true do |t|
    t.integer  "pesticide_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "problems", ["pesticide_id"], name: "index_problems_on_pesticide_id", using: :btree
  add_index "problems", ["product_id"], name: "index_problems_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "date_published"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree
  add_index "products", ["date_published"], name: "index_products_on_date_published", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "user_id"
    t.string   "name"
    t.string   "email"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
