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

ActiveRecord::Schema.define(version: 20130607063944) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "name_kana"
    t.string   "zip"
    t.string   "address"
    t.string   "tel"
    t.string   "fax"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name"], name: "index_companies_on_name", using: :btree

  create_table "divisions", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "name_kana"
    t.string   "zip"
    t.string   "address"
    t.string   "tel"
    t.string   "fax"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "divisions", ["company_id"], name: "index_divisions_on_company_id", using: :btree
  add_index "divisions", ["name"], name: "index_divisions_on_name", using: :btree

  create_table "personals", force: true do |t|
    t.integer  "division_id"
    t.string   "name"
    t.string   "name_kana"
    t.string   "title"
    t.string   "mail"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personals", ["division_id"], name: "index_personals_on_division_id", using: :btree
  add_index "personals", ["name"], name: "index_personals_on_name", using: :btree

end
